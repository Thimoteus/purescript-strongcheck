module Test.StrongCheck.Data.ApproxNumber where

import Prelude

import Test.StrongCheck.Arbitrary (class Coarbitrary, class Arbitrary, coarbitrary, arbitrary)

-- | A newtype for `Number` whose `Eq` instance uses an epsilon value to allow
-- | for precision erros when comparing.
newtype ApproxNumber = ApproxNumber Number

-- Approximate equality comparison
approximateEqual :: Number -> Number -> Boolean
approximateEqual x y = (y - x) <= epsilon && (y - x) >= (-epsilon)
  where
  epsilon = 0.00000001

infix 2 approximateEqual as =~=

instance arbitraryApproxNumber :: Arbitrary ApproxNumber where
  arbitrary = ApproxNumber <$> arbitrary

instance coarbitraryApproxNumber :: Coarbitrary ApproxNumber where
  coarbitrary (ApproxNumber n) = coarbitrary n

instance eqApproxNumber :: Eq ApproxNumber where
  eq (ApproxNumber x) (ApproxNumber y) = x =~= y

instance ordApproxNumber :: Ord ApproxNumber where
  compare (ApproxNumber x) (ApproxNumber y) = compare x y

instance semiringApproxNumber :: Semiring ApproxNumber where
  add (ApproxNumber x) (ApproxNumber y) = ApproxNumber (x + y)
  zero = ApproxNumber zero
  mul (ApproxNumber x) (ApproxNumber y) = ApproxNumber (x * y)
  one = ApproxNumber one

instance ringApproxNumber :: Ring ApproxNumber where
  sub (ApproxNumber x) (ApproxNumber y) = ApproxNumber (x - y)

instance commutativeRingApproxNumber :: CommutativeRing ApproxNumber

instance divisionRingApproxNumber :: DivisionRing ApproxNumber where
  recip (ApproxNumber x) = ApproxNumber (1.0 / x)

instance euclideanRingApproxNumber :: EuclideanRing ApproxNumber where
  degree (ApproxNumber x) = degree x
  div (ApproxNumber x) (ApproxNumber y) = ApproxNumber (x / y)
  mod (ApproxNumber x) (ApproxNumber y) = ApproxNumber (x `mod` y)
