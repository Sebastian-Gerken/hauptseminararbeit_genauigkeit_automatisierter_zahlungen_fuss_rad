import time

def count():
    s = 0
    for i in range(1, 10000001):
        s += i
    return s

start = time.time()
count()
end = time.time()
print(end - start)
