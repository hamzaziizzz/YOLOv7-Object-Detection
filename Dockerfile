# syntax=docker/dockerfile:1

FROM python:3.10.8-slim-buster

WORKDIR /flask-yolo

COPY requirements.txt requirements.txt
RUN pip3 install torch --no-cache-dir
RUN pip3 install -r requirements.txt

# For setting time zone
#https://grigorkh.medium.com/fix-tzdata-hangs-docker-image-build-cdb52cc3360d
ENV TZ=Asia/Kolkata
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt update -y && apt install ffmpeg libsm6 libxext6  -y

RUN pip install Flask
RUN pip install Flask-Bootstrap

COPY . .

CMD [ "python3", "-m" , "flask", "--app", "flaskApp", "run", "--host=0.0.0.0"]
