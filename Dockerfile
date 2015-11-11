FROM ruby:2.1.4

RUN mkdir /apps
WORKDIR /apps

#Install some dependencies
RUN git clone https://github.com/vitalsource/LTI2-Reference.git
RUN git clone https://github.com/bsletten/ruby-jsonld-signatures.git

ADD ./ /apps/cbe_competency_engine

WORKDIR /apps/cbe_competency_engine
RUN bundle install --deployment
RUN rake
