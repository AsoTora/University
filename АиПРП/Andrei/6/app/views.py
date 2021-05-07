from flask import render_template, url_for, flash, redirect, request
from app import app, db
from app.models import Car
from app.forms import CarForm, FindModelForm, FindPriceForm


@app.route("/")
@app.route("/home")
def home():
    cars = Car.query.all()
    return render_template('home.html', title="Lab6_shvedau", objects=cars)


@app.route("/new_car", methods=['GET', 'POST'])
def new_car():
    form = CarForm()
    if form.validate_on_submit():
        Car.add_car(model=form.model.data, price=form.price.data)
        flash('Car has been added!', 'success')
    return render_template('create_car.html', title='New Student',
                           form=form)


@app.route("/find_model_by_price", methods=['GET', 'POST'])
def find_model_by_price():
    form = FindModelForm()
    cars = {}
    if form.validate_on_submit():
        cars = [i[0].model for i in db.session.execute(Car.query.filter(
            Car.price > form.price_min.data, Car.price < form.price_max.data))]
        print(cars)
    return render_template('find_model_by_price.html', title='Find_model_by_price',
                           form=form, data=cars)

@app.route("/find_price_by_model", methods=['GET', 'POST'])
def find_price_by_model():
    form = FindPriceForm()
    cars = {}
    if form.validate_on_submit():
        cars = [i[0] for i in db.session.execute(Car.query.filter(Car.model.like(f'%{form.model.data}%')))]
    return render_template('find_price_by_model.html', title='Find_price_by_model',
                           form=form, data=cars)
