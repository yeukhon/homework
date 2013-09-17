# Homework 1

## Problem 1

To prove that L is decidable, we can first prove that its complement ``L'`` is decidable. 

``L'`` = { <M', w>: M' is a TM which always move its head to the right.}

First, there exists ``M_L`` a TM that can decides L. To show L is indeed decidable, we simulate M' on input w by constructing M_L' that decides ``L'``.  Given ``L'``, ``M_L'`` will reject ``L'`` if the head moves to the left!

#### case 1

Regardless of |w| and |Q| and |transitions|, if M' has consumed all characters of input w, M' will reach the blank symbol and then M_L' will accept.

#### case 2

The input can be very long (and potentially infinitely long). Given |Q| <<< |w| we will re-visit some states again by Pigeonhole Principle. We will enter a loop. The loop could be infinite. Even if we never stop consuming w because w is infinitely long, as long as the head still moving to the right, that's fine. If we see any configuration moving to the left, we know we fall under case 3.

#### case 3

As stated L' specification, L' will be rejected by M_L' when M' ever moved left.

So M_L' is decidable. Since a language is closed under the complement (from ``Elements of the Theory of Computation``), we know that M_L is also decidable. 


## Problem 3

Suppose the language D does exists, then it is trivial to see that C must be turing-recognizable because if y is found in D, D is said to accept and C will accept. 

If, on the other hand, C is indeed recognizable and recognizes input x, then we must construct a TM that decides D. We can make such TM: the TM accepts x when the TM finds y. That's the definition of D anyway. If x is accepted by the TM that decides D, it must means x is also recognized by the language C.

## Problem 4

Here is how I approach the problem. First, according to http://kilby.stanford.edu/~rvg/154/handouts/decidability.html, I learned that "[a] language is recognizable if and only if it is enumerable." We can see this too using the diagonalization technique. We can enumerate an infinite set using such technique. If the set is indeed infinite, pick x that is far far far from the starting point, there exists a TM that can recognize whether x is in L (TM accepts x if it is in L, otherwise it either rejects or runs forever - which can happen given the set is infinite). 

So the first direction:  Suppose L is decidable, then we must have an enumerator E enumerates all strings in L in an increasing order. We know L is decidable so it must be recognizable by some TM M. It means we must have an enumerator. We shall now prove the enumerator E must work in an interesting order. I think one way to prove it is again simulate the diagonalization technique. The TM will accept all strings in L in an increasing order (for example, if {a,b,c} are in the alphabet, then we can have ``{a, ab, ac, b, ba, bc, c, ca, cb, abc, acb, bac, bca, cab, cba}``.

The other direction: Suppose now we have such E exists, L must is decidable. Well, we know by fact now that if an E exists for L, L must be decidable. 
