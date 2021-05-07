from app import db


class Car(db.Model):
    __tablename__ = 'cars'
    id = db.Column(db.Integer, primary_key=True)
    model = db.Column(db.String(30), nullable=False)
    price = db.Column(db.Integer, nullable=False)

    def __repr__(self):
        return f"{self.id}. {self.model}: {self.price}$"

    @classmethod
    def add_car(cls, **kw):
        # use as: Car.add_car(model="", price="")
        car = cls(**kw)
        db.session.add(car)
        db.session.commit()


class CarList(db.Model):
    __tablename__ = 'carlists'
    id = db.Column(db.Integer,primary_key=True)
    # foreign key of the car
    car_id = db.Column(db.Integer, db.ForeignKey('cars.id'))


