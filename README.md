Airport Challenge
=================

The Week 3 Friday Challenge at Makers Academy aims to reinforce our understanding of testing with doubles. 

For this task, I created a set of classes and modules to simulate air traffic control at an airport. Planes can land at the airport as long as the airport has not reached full capacity. When the weather is stormy, all traffic is halted, and planes are not allowed to land or take off.

How to use
----------
Clone the repository:
```shell
$ git clone git@github.com:ch2ch3/airport-challenge.git
```

Change into the directory:
```shell
$ cd airport-challenge
```

To run the tests:
```shell
$ rspec
```

To see the code in action, open IRB and require the files:
```shell
$ irb
  > require './lib/weather'
  > require './lib/plane'
  > require './lib/airport'
```

Create a new airport:
```shell
  > changi = Airport.new
```

Create some planes:
```shell
  > SQ317 = Plane.new
  > SQ305 = Plane.new
  > SQ319 = Plane.new
  > SQ321 = Plane.new
```

Land a plane:
```shell
  > changi.land(SQ321)
```

If the weather is stormy, you may need to try landing the plane a few times.

Send a plane for take off:
```shell
  > changi.take_off(SQ321)
```

Check the planes in the airport:
```shell
  > changi.planes
```