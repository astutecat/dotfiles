local M = {
[[We do this not because it is easy,
but because we thought it would be easy.
  - The Programmer's Credo]],
[[A distributed system is one where the failure of a machine
you've never heard of stops you from getting any work done.
  - Leslie Lamport]],
[[Hope is not a strategy.
  - Site reliability engineers' motto.]],
[[If it's a good idea, go ahead and do it.
It's much easier to apologize than it is to get permission.
  - Grace Hopper]]
}

return M[math.random(#M)]
