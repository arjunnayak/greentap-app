
import string
import json
import csv
import random
import base64
import time
import os
from urlparse import urlsplit

import requests
from slugify import slugify
import sys

API_HOST = os.environ['API_HOST'] if 'API_HOST' in os.environ else 'http://localhost:3001/api'

convert_category = {
    'flowers': 'flower',
    'flower': 'flower',
    'concentrates': 'concentrate',
    'concentrate': 'concentrate',
    'edibles': 'edible',
    'edible': 'edible',
    'topicals': 'topical',
    'topical': 'topical'
}

def product_row_to_dict(row):
    result = dict()
    result['category'] = make_safe(row['category'])
    result['sub_category'] = make_safe(row['sub_category'])
    result['name'] = make_safe(row['product_name'])
    result['image'] = make_safe(row['product_image'])
    result['description'] = make_safe(row['product_description'])
    result['thc_level'] = make_safe(row['thc_level'])
    result['cbd_level'] = make_safe(row['cbd_level'])
    result['strain_type'] = make_safe(row['strain_type'])
    result['unit_count'] = make_safe(row['unit_count'])
    result['unit_count_type'] = make_safe(row['unit_count_type'])
    result['unit_price'] = make_safe(row['unit_price'])
    return result

def make_safe(s):
    if not s:
        return None
    return s.decode('utf-8').strip(' \t\n\r')

def gen_random_string(strLength):
    return ''.join(random.SystemRandom().choice(string.ascii_uppercase + string.digits) for _ in range(strLength))

def url_to_base64(url):
    return base64.b64encode(requests.get(url, stream=True).content)

def look_for_strain_type(desc):
    loweredDesc = desc.lower()
    if 'sativa' in loweredDesc:
        return 'sativa'
    elif 'indica' in loweredDesc:
        return 'indica'
    else:
        return 'hybrid'

def get_filetype_from_image_name(image_name):
    image_ext = image_name.split('.')[-1].lower()
    if image_ext == 'jpg' or image_ext == 'jpeg':
        return 'image/jpg'
    elif image_ext == 'png':
        return 'image/png'
    else:
        print 'cannot process image ext type', image_ext
        return None
        # raise RuntimeError('cannot process image ext type')

def construct_image_data(image_url):
    base64 = url_to_base64(image_url)
    filename = urlsplit(image_url)[2].split('/')[-1].split('%252f')[-1]
    filename = make_safe(filename.replace('%', '.'))
    # print filename
    filetype = make_safe(get_filetype_from_image_name(filename))
    if not filetype:
        return None
    # print filetype
    filedata = 'data:{0};base64,{1}'.format(filetype, base64)
    return {
        'filename': filename,
        'data': filedata,
        'filetype': filetype
    }

def get_brands(product_rows):
    brands = {}
    for row in product_rows:
        brand_name = make_safe(row['brand_name'])
        if brand_name not in brands:
            brands[brand_name] = {
                'products': [],
                'description': make_safe(row['brand_description'][:1024]),
                'states': make_safe(row['state']).replace(' ', ''),
                'brand_logos': make_safe(row['brand_logos']),
            }
        brands[brand_name]['products'].append(product_row_to_dict(row))
    return brands

def add_brand_image(brand_name, brand_image_link, cookies, headers):
    image_data = {}
    image_data['name'] = brand_name
    if 'filepicker' in brand_image_link:
        print 'ERROR, cannot support image urls with filepicker: ', brand_image_link
        return

    image_data['image'] = construct_image_data(brand_image_link)
    if not image_data['image']:
        print 'ERROR, cant construct image data'
        return

    # print 'sending data:', image_data
    set_brand_image_resp = requests.post(API_HOST + '/brands/_setImage', json=image_data)
    resp_data = set_brand_image_resp.json()

    if set_brand_image_resp.ok:
        print 'set brand image for ', resp_data['name']
        return
    else:
        print 'ERROR setting brand image for ', image_data['name'], ' with data ', image_data['image']
        return

def get_unit_price(unit_price):
    # remove $ sign and decimal
    # this is reliant on the spreadsheet having $xx.xx format
    return product['unit_price'][1:].replace('.', '')


def check_api_health():
    print "Checking api health..."
    attempts = 10
    counter = 0
    sleep = 0.5
    while counter < attempts:
        try:
            r = requests.get(API_HOST + '/system/health')
            if 200 <= r.status_code < 300:
                print "Health check successful"
                break
            else:
                print "Health check failed: " + str(r.status_code) + \
                    ", retrying in " + str(sleep) + " seconds"
        except requests.exceptions.ConnectionError:
            print "Health check failed: could not connect, retrying in " + \
                str(sleep) + " seconds"

        time.sleep(sleep)
        counter += 1


file_path = os.environ['CSV_FILE'] if 'CSV_FILE' in os.environ else '/Users/arjunnayak/workspace/greentap-app/server/data/all_products.csv'

columns = ['product_image', 'category', 'sub_category', 'product_name', 'short_description', 'product_description', 'strain_type',
           'thc_level', 'cbd_level', 'unit_count', 'unit_price', 'unit_count_type', 'brand_name', 'state', 'brand_description', 'brand_logos']

check_api_health()

with open(file_path, 'rb') as csvfile:
    product_rows = csv.DictReader(csvfile, columns)

    # skip the first row due to headers
    next(product_rows, None)

    brands = get_brands(product_rows)

    # print sorted(list(brands.keys()))

    for brand_name, brand in brands.items():
        print 'adding brand: ', brand_name

        email = slugify(brand_name) + '@' + gen_random_string(12) + '.com'
        primary_state = brand['states'].split(', ')[0]
        brand_desc = brand['description']
        states = brand['states']
        brand_image_link = brand['brand_logos']
        temp_password = 'test'
        reg_user = {'firstName': brand_name, 'lastName': brand_name, 'email': email, 'password': temp_password, 'confirmPassword': temp_password,
                    'businessType': 'seller', 'businessName': brand_name, 'state': primary_state, 'description': brand_desc, 'statesAvailableIn': states,
                    'licenseState': 'CA', 'licenseNumber': 'CA12345678', 'licenseType': 'test-license-type',
                    'phone': '5101112222', 'address': '123 Example St', 'city': 'San Francisco', 'zip': '93715'}

        reg_resp = requests.post(API_HOST + '/auth/register', data=reg_user)

        if not reg_resp.ok:
            print '  ERROR: could not register user with data', reg_user
            print '  response from server:', reg_resp.json()
            continue

        login_user = {'email': email, 'password': temp_password}
        login_resp = requests.post(API_HOST + '/auth/login', data=login_user)
        if not login_resp.ok:
            print '  ERROR: could not login user with data', login_user
            continue

        brand_user = login_resp.json()
        cookies_to_send = login_resp.cookies
        headers_to_send = {'Accept': 'application/json', 'Content-Type': 'application/json'}

        add_brand_image(brand_name, brand_image_link, cookies_to_send, headers_to_send)

        for product in brand['products']:
            # print product

            # skip weird fileformat that we can't currently process
            if 'filepicker.io' in product['image']:
                continue

            image_data = construct_image_data(product['image'])
            description = product['description'][:1024] if product['description'] and len(product['description']) > 0 else 'No description'

            pricings = None
            if product['unit_count'] and product['unit_count_type'] and product['unit_price']:
                pricings = [
                    {
                        'unitCount': make_safe(product['unit_count']),
                        'unitCountType': make_safe(product['unit_count_type']),
                        'unitPrice': get_unit_price(make_safe(product['unit_price']))
                    }
                ]

            product_data = {
                'business_id': str(brand_user['user']['business']['id']),
                'product': {
                    'name': product['name'],
                    'category': convert_category[product['category']],
                    'subCategory': product['sub_category'],
                    'strain_type': look_for_strain_type(description),
                    'desc': description,
                    'image': image_data if image_data else None,
                }
            }
            if pricings:
                product_data['product']['pricings'] = pricings

            product_data = json.loads(json.dumps(product_data))
            add_resp = requests.post(API_HOST + '/products/add', json=product_data, cookies=cookies_to_send)
            if add_resp.ok:
                print '  adding product', add_resp.json()['product']['name']
            else:
                print '  ERROR: could not add product with data', product_data
                print '  got response', add_resp.json()
        print '<<<<<<<<<<<<<<<<<'
