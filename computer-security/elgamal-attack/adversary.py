#!/usr/bin/env python

# IDEA: start a new process (which will play the role of the challenger
# for the CPA game), and communicate with it via stdin and stdout.

import sys
from subprocess import *
from Crypto import Random
from Crypto.Random import random
from Crypto.PublicKey import ElGamal
import cPickle as pcl
import numbthy
import random

p1 = Popen(["./chall.py"], stdin=PIPE, stdout=PIPE, close_fds=True)

# start the conversation with a "hello" message
hellomesg = "hello"
pcl.dump(hellomesg, p1.stdin)
p1.stdin.flush()

# now read the key.
key = pcl.load(p1.stdout)

# NOTE: the public key consists of 3 parts:
# g is the generator
# y is g^x (x is secret)
# p is the prime.

# TODO: you need to find two messages that you can distinguish via
# their ciphertext.  They have to be of equal length.  Note that
# you can just use long integers instead of strings (recommended).


m1 = '' # a message with 1
m2 = '' # a message with -1

print key.g
start = random.randint(1, key.p)
p_minus = (key.p-1)/2

# ensure I am not cheating
while not m1:
    ans = numbthy.powmod(start, p_minus, key.p)
    if ans == 1:
        m1 = start
        print 'm1 got something ', m1
    start = random.randint(1, key.p)

# Thanks to Linda reminding wes wrote this in his note!
m2 = key.g

# send the pair of messages:
#mesgList = ["message0", "message1"]
mesgList = [m1, m2]

print 'm1 is: ', m1
print 'm2 is: ', m2

pcl.dump(mesgList, p1.stdin)
p1.stdin.flush()

# now get the challenge ciphertext.
ct = pcl.load(p1.stdout)

# TODO: you should be able to guess the right message with probability 1

lv_gr = numbthy.powmod(ct[0], (key.p-1)/2, key.p)
lv_mgak = numbthy.powmod(ct[1], (key.p-1)/2, key.p)

if lv_gr/lv_mgak == 1:
    guess = 0
else:
    guess = 1
#guess = 1

# now report our guess
pcl.dump(guess, p1.stdin)
p1.stdin.flush()

p1.stdin.close()

sys.exit()
