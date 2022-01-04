// The client code creates a builder object, passes it to the director and then initiates the construction process.
//The end result is retrieved from the builder object.
void main() {
  Director director = Director();
  CarBuilder builder = CarBuilder();
  director.constructSportsCar(builder);
  Car car = builder.getCar();

  CarManualBuilder builder2 = CarManualBuilder();
  director.constructSportsCar(builder2);
  Manual manual = builder2.getManual();

  print(car.engine);
  print(manual.engine);
}

// Using the Builder pattern makes sense only when the object being built is a complex object.
// If the object being built is a simple object, it is better to use the Factory pattern.
// The following two products are related, altough they don't have a common interface.

// A car can have a GPS, trip computer, and some number of seats.
// Different models of cars can (sports car, SUV, cabriolet, etc.) might have different features.
class Car {
  int? seats;
  String? engine;
  bool? tripComputer;
  bool? gps;
}

// Each car should have a manual that corresponds to the car's configuration and descibes all its features.
class Manual {
  int? seats;
  String? engine;
  bool? tripComputer;
  bool? gps;
}

// The builder interface specifies methods for building the parts of the product objects.
abstract class Builder {
  void reset();
  void setSeats(int number);
  void setEngine(String engine);
  void setTripComputer(bool tripComputer);
  void setGPS(bool gps);
}

// The concrete builders follow the builder interface and provide specific implementations of the building steps.
// Your program may have several variations of builders, implemented differently.
class CarBuilder implements Builder {
  late Car _car;

// A fresh builder instance should have a blank product object, which is used in further assembly.
  CarBuilder() {
    reset();
  }

  Car getProduct() {
    return _car;
  }

// The reset method clears the object being built.
  @override
  void reset() {
    _car = Car();
  }

  @override
  void setSeats(int number) {
    _car.seats = number;
  }

  @override
  void setEngine(String engine) {
    _car.engine = 'Racecar ' + engine;
  }

  @override
  void setTripComputer(bool tripComputer) {
    _car.tripComputer = tripComputer;
  }

  @override
  void setGPS(bool gps) {
    _car.gps = gps;
  }

  Car getCar() {
    return _car;
  }

/*
Concrete builders are supposed to provide their own methods for retrieving results.
That's because various types of builders may create entirely different products that don't follow the same interface.
Therefore, such methods cannot be declared in the base Builder interface (at least in a statically typed programming language).

Usually after returning the end result, a builder instance is expected to be ready to start building a new product.
That's why it's a usual practice to call the reset method at the end of the `getProduct` method body.
However, this behavior is not mandatory, and you can make your builders wait for an explicit reset call from the client code.
before starting to construct a new product.
*/

}

// Unlike other creational patterns, builder lets you construct products that don't follow the same common interface.
class CarManualBuilder implements Builder {
  late Manual _manual;

  CarManualBuilder() {
    reset();
  }

  Manual getManual() {
    return _manual;
  }

  @override
  void reset() {
    _manual = Manual();
  }

  @override
  void setEngine(String engine) {
    _manual.engine = engine + ' Manual';
  }

  @override
  void setGPS(bool gps) {
    _manual.gps = gps;
  }

  @override
  void setSeats(int number) {
    _manual.seats = number;
  }

  @override
  void setTripComputer(bool tripComputer) {
    _manual.tripComputer = tripComputer;
  }
}

// The Director is responsible for executing the building steps in a particular sequence.
// It is helpful when producing products according to a specific order or configuration.
// Strictly speaking, the Director class is optional, since the client can control builders directly.
class Director {
  late Builder _builder;

// The director works with any builder instance that the client code passes to it.
// This way, the client code may alter the final type of the newly assembled product.
  void setBuilder(Builder builder) {
    _builder = builder;
  }

// The Director can construct several product variations using the same building steps.
  void constructSportsCar(Builder builder) {
    _builder = builder;
    _builder.reset();
    _builder.setSeats(4);
    _builder.setEngine('Sport Engine');
    _builder.setTripComputer(true);
    _builder.setGPS(true);
  }

  void constructSUV(Builder builder) {
    _builder.reset();
    _builder.setSeats(5);
    _builder.setEngine('SUV Engine');
    _builder.setTripComputer(true);
    _builder.setGPS(true);
  }
}
