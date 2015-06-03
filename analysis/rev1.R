#a = impulse; b = model predictor; y = activation

a=rnorm(100)
b=rnorm(100)
y=rnorm(100)

mod_orth=lm(b~a)
resB=resid(mod_orth)

mod1=lm(y~a+b)
mod2=lm(y~a+resB)

coefficients(mod1)
coefficients(mod2)
