const LocalStrategy = require('passport-local').Strategy
const db = require('./db')

module.exports = passport => {

  const localOptions = {
    usernameField: 'email'
  }
  
  passport.use('local-login', new LocalStrategy(localOptions, (email, password, done) => {
    const GET_USER = 'SELECT id, email, first_name, last_name, business_type FROM public.user WHERE email = $1 and password = $2;'
    var user = null;
    db.task(t => {
      return t.one(GET_USER, [email, password])
        .then(authedUser => {
          user = authedUser   
          if(user.business_type === "brand") {
            const GET_BUSINESS = 'SELECT * FROM public.business WHERE user_id = $1';
            return t.one(GET_BUSINESS, [user.id])
          } else {
            return done(null, user)
          }
        })
        .catch(error => {
          //failed to get user...have business handler return done(null, false) since it can't be done here
          //..why it can't be done here: returning here will return to the then block which doesn't indicate an error
          return
        })
    }).then(business => {
        if(!user) return done(null, false)
        user.business = business
        console.log('successfully got user and business and logged in')
        return done(null, user)
      })
      .catch(error => {
        console.log('passport local login error', error)
        return done(error)
      })
  }))
  
  passport.serializeUser((user, done) => {
    console.log('serialize user', user)
    done(null, user);
  })
  
  // used to deserialize the user
  passport.deserializeUser((user, done) => {
    return done(null, user)
  //   const DESERIALIZE_USER = 'SELECT id, email, first_name, last_name, business_type FROM public.user WHERE email = $1;'
  //   var user = null;
  //   db.task(t => {
  //     return t.one(DESERIALIZE_USER, [email])
  //     .then(authedUser => {
  //       user = authedUser   
  //       if(user.business_type === "brand") {
  //         const GET_BUSINESS = 'SELECT * FROM public.business WHERE user_id = $1';
  //         return t.one(GET_BUSINESS, [user.id])
  //       } else {
  //         return done(null, user)
  //       }
  //     })
  //     .catch(error => {
  //       //failed to get user...have business handler return done(null, false) since it can't be done here
  //       //..why it can't be done here: returning here will return to the then block which doesn't indicate an error
  //       return
  //     })
  //   }).then(business => {
  //       if(!user) return done(null, false)
  //       user.business = business
  //       console.log('deserialize user', user)
  //       return done(null, user)
  //     })
  //     .catch(error => {
  //       console.log('passport deserialize user error', error)
  //       return done(error)
  //     })
  })
}
