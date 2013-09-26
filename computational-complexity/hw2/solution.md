# Homework 2

attempted by Yeuk Hon on 09/26/2013.


## Problem 1

Deciding whether there exists a TM that decides another TM has a useless state
is saying whether there exists a TM that can detects whether another TM has an 
infinite loop on an input ``w``. 

Suppose for contradiction that problem 1 is decidable (and the above statement is true).
We immeidately see the claim is a contradiction because deciding whether a TM has an 
infinite loop is the ATM problem:

    If on input w we can tell it is in an infinite loop we must halt on input w either
    accepting or rejecting. But infinite loop never reaches a final state, which is
    a useless state in the original problem.

How can we tell if w is acceptable/hatable? This is ATM problem itself by definition - 
for ``ATM = { <M,w>: M accepts }``.

(another way to think of this problem is by thinking of a sequential computer program
ever reaches a particular line).

Thus, since ATM is not decidable, it must follows that problem 1 is also not decidable.


## Problem 2

We can solve this using the ATM machine as we studied in lecture.

    ATM = { <M,w>: M accepts w}

Suppose the problem is a language L:

    L = { <M, w>: M accepts w and M writes a non-blank symbol on its second tape. }

Then suppose we have a TM called T that decides L and there is a TM H decides ATM,
which decides TM on input D and w

    T(M,w) = accepts if M accepts; rejects if M does not accept
    H(T, w) = H((M,w),w) = accepts if T accepts which means M accepts.

Since H is a machine that decides ATM, and since ATM problem is undecidable, it follows
that by contradiction we cannot possibly have a TM that decides the original problem.


## Problem 3

The PCP problem is for alphabet other than unary - you need to do encoding on multiple
symbols to determine a match. For unary you do not need to. 

If the top sequence and the bottom sequence have the same size, that's always a match (
after all 1^N == 1^M if N = M where N = |top| and M = |bottom| for all tiles. 

(also see my attempt on number 4 how to reduce to PCP)


## Problem 4

This problem can be reduced to PCP. The original PCP problem has an arbitary alpabet of
an arbatary size of at least greater than 1 (we show in #3 unary is decidabke). For our 
purpose, PCP with |sigma| > 2, we encode extra character with either {0,1}. That gives 
the same ordering as encoding with alphabet of just {0,1}. Therefore, we have reduced
the problem to just PCP which is clearly undecidable.

This is the same for unary because mapping {0,1,2,3,....} to {1} always yield an answer.

## Problem 5

My attempt is as follows. w^R is a reptition of {0,1,2,3, ....}. We can build a TM that
accepts w. Start with R = 0, enumerate by dovetail technique (see http://en.wikipedia.org/wiki/Dovetailing_%28computer_science%29),
we can start building up new input of w repetition from {0,1,2,3,4....}. 

         0  1 2 3 4 5
      0  // 
      1 |/
      2
      3
      4        (dovetail technique)


Suppose there exists a TM T that decides a turing machine T1 (decides w^r) which decides on TM T2 (decides on input (w)).

* T2(w) accepts if w is accepted

* T1(T2, w^r) accepts if w^r is accepted given from T2

* T(T1, w) accepts.

As we feed in the new input (as we enumerate all repetition of the same size of the natural number
set), we feed that into another TM that decides w^R. 
But we know ATM is undecidable, and T is a turing machine that decides AMT. Hence, by contradiction
such TM does not decide our requirement.


