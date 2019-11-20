FROM raspbian/stretch

# Install dependancies
RUN apt-get update && apt-get -q -y install  \
curl unzip \
build-essential libatlas-base-dev python3-pip git \
libwebp6 libwebp-dev libtiff5 libtiff5-dev libjasper1 libjasper-dev \
libilmbase12 libilmbase-dev libopenexr22 libopenexr-dev  \
libgstreamer0.10-0 libgstreamer0.10-dev libgstreamer1.0-0 libgstreamer1.0-dev \
libavcodec-dev libavformat57 libavformat-dev libswscale4 libswscale-dev \
libqtgui4 libqt4-test
RUN git clone https://github.com/PINTO0309/Tensorflow-bin.git &&  (cd Tensorflow-bin && \
     pip3 install tensorflow-1.15.0-cp35-cp35m-linux_armv7l.whl opencv-python Pillow numpy)

RUN mkdir /home/models
COPY models /home/models

RUN apt-get update && apt-get -q -y install protobuf-compiler
ENV PYTHONPATH="${PYTHONPATH}:/home/models"
ENV PYTHONPATH="${PYTHONPATH}:/home/models/research"
ENV PYTHONPATH="${PYTHONPATH}:/home/models/research/slim"
RUN (cd /home/models/research && protoc --python_out=. object_detection/protos/*)
