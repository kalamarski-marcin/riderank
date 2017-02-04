module TaxiRides
  # :nodoc:
  class RandomDistanceService < DistanceMatrixService
    def execute
      rand(50)
    end
  end
end
