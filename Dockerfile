FROM python:3.7-slim
WORKDIR /code

COPY requirement.txt requirement.txt
RUN pip install -r requirement.txt

RUN apt-get update && apt-get upgrade
RUN apt-get install -y python3-opencv
COPY object_detection.py object_detection.py
COPY yolov3-tiny.cfg yolov3-tiny.cfg
COPY yolov3-tiny.weights  yolov3-tiny.weights
COPY coco.names coco.names
COPY wsgi.py wsgi.py


CMD ["gunicorn", "-b", "0.0.0.0:5000", "--log-level",  "debug", "wsgi:app"]

EXPOSE 5000
