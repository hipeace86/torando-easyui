# -*- coding: utf-8 -*-

import sys
import tornado.ioloop
import tornado.httpserver
import tornado.web
from tornado.options import options, define, parse_command_line
import os

import lib.homehandler
import Right.Handler
from UI.CommonModules import StatusCodeModule, RadioModule, CheckboxModule
from lib.urlmap import urlmap
from lib.Route import session


class Application(tornado.web.Application):

    def __init__(self):
        handlers = tuple(urlmap.handlers)
        settings = dict(
            AppTitle='Example for easyui admin',
            static_path=os.path.join(os.path.dirname(__file__), "static"),
            template_path=os.path.join(os.path.dirname(__file__), "templates"),
            debug=True,
            xsrf_cookies=True,
            autoescape=None,
            login_url='/login',
            cookie_secret='61oETzKXQAGaYdkL5gEmGEJJFuYh7EQnp2XdTP1o/V==',
            ui_modules={'StatusCodeModule': StatusCodeModule,
                        'RadioModule': RadioModule,
                        'CheckboxModule': CheckboxModule
                        },
        )
        self.db = session
        tornado.locale.load_translations('i18n')
        tornado.ioloop.PeriodicCallback(self._ping_db, 4 * 3600 * 1000).start()
        tornado.web.Application.__init__(self, handlers, **settings)

    def _ping_db(self):
        self.db.execute('show variables')
        self.db.close_all()

define('port', type=int, default=4000)


def main():
    parse_command_line()
    http_server = tornado.httpserver.HTTPServer(Application())
    http_server.listen(options.port)
    tornado.ioloop.IOLoop.instance().start()

if __name__ == "__main__":
    reload(sys)
    sys.setdefaultencoding('utf-8')
    main()
# python -m cProfile -o profile_data.pyprof script_to_profile.py
# gprof2dot.py -f pstats profile_data.pyprof | dot -Tpng -o output.png
