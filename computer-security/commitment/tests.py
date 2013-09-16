#!/usr/bin/python

from subprocess import Popen, PIPE

for i in xrange(100):
    p = Popen(['python', 'committer.py'], stdin=PIPE, stdout=PIPE, stderr=PIPE)
    pout, pin = p.communicate()
    
    print pin
    assert 'Cheater' not in pin
