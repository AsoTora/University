from flask_wtf import FlaskForm
from wtforms import StringField, SubmitField
from wtforms.fields.core import IntegerField
from wtforms.validators import DataRequired, Length
from app.models import Car



class CarForm(FlaskForm):
    model = StringField('Model',
                        validators=[DataRequired(), Length(min=2, max=30)])
    price = IntegerField('Price',
                         validators=[DataRequired()])
    submit = SubmitField('Add to the DB')


class FindModelForm(FlaskForm):
    price_min = IntegerField('Price_min',
                             validators=[DataRequired()])
    price_max = IntegerField('Price_max',
                            validators=[DataRequired()])
    submit = SubmitField('Find')

class FindPriceForm(FlaskForm):
    model = StringField('Model',
                        validators=[DataRequired(), Length(min=1, max=30)])
    submit = SubmitField('Find')