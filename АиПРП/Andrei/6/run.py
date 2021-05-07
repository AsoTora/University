from app import app, db
from app.models import Car

if __name__ == '__main__':
    # clear and populate
    with app.app_context():
        # db.drop_all()
        db.create_all()
    app.run(debug=True)

#Car.query.filter(Car.price > 5))
# db.engine.execute('''INSERT INTO department VALUES (1, 'фиту', 'www.fitu.com')''')