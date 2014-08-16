env = ENV["RACK_ENV"] || "development"

DataMapper.setup(:default, "postgres://localhost/waffle_#{env}")

DataMapper.finalize
