class Client(object):
    def __init__(self, name, address, cpf, age):
        self.name = name
        self.address = address
        self.cpf = cpf
        self.age = age


class Manager(object):
    def __init__(self):
        self.name = None
        self.email = None


class Equipment(object):
    def __init__(self):
        self.model = None
        self.brand = None
        self.consumption = None


class Consumption(object):
    def __init__(self):
        self.horas = None
        self.consumption = None


class Agency(object):
    def __init__(self):
        self.city = None
        self.address = None
        self.manager = None


class Support(object):
    def __init__(self):
        self.call = None
        self.protocol = None