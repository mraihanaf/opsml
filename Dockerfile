FROM python:3.13-alpine
WORKDIR /usr/src/app

COPY requirements.txt ./

RUN pip install --no-cache-dir -r requirements.txt
# use gunicorn as a production server
RUN pip install gunicorn
COPY . .

CMD ["gunicorn", "--bind", "0.0.0.0:2000", "app:app"]
EXPOSE 2000