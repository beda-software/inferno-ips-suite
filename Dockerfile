FROM ruby:3.3.6

ENV INSTALL_PATH=/opt/inferno/
ENV APP_ENV=production
RUN mkdir -p $INSTALL_PATH

WORKDIR $INSTALL_PATH

ADD lib/inferno_ips/version.rb $INSTALL_PATH/lib/inferno_ips/version.rb
ADD *.gemspec $INSTALL_PATH
ADD Gemfile* $INSTALL_PATH
RUN gem install bundler
# The below RUN line is commented out for development purposes, because any change to the
# required gems will break the dockerfile build process.
# If you want to run in Deploy mode, just run `bundle install` locally to update
# Gemfile.lock, and uncomment the following line.
# RUN bundle config set --local deployment 'true'
RUN bundle install

ADD . $INSTALL_PATH

EXPOSE 4567
CMD ["bundle", "exec", "puma"]
