require_relative 'database'

class Usuario < Sequel::Model(DB[:usuarios])
'''