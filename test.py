import timeit

cy = timeit.timeit('core.setup()\ncore.move()', setup='import core.main as core', number=100)
py = timeit.timeit('core.setup()\ncore.move()', setup='import core.mm as core', number=100)

print(cy, py)
