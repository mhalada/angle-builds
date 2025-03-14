# This file inherits default targets for Node addons, see https://github.com/nodejs/node-gyp/blob/master/addon.gypi
{
  # https://github.com/springmeyer/gyp/blob/master/test/make_global_settings/wrapper/wrapper.gyp
  'make_global_settings': [
    ['CXX', '<(module_root_dir)/mason_packages/.link/bin/clang++'],
    ['CC', '<(module_root_dir)/mason_packages/.link/bin/clang'],
    ['LINK', '<(module_root_dir)/mason_packages/.link/bin/clang++'],
    ['AR', '<(module_root_dir)/mason_packages/.link/bin/llvm-ar'],
    ['NM', '<(module_root_dir)/mason_packages/.link/bin/llvm-nm']
  ],
  'includes': [ 'common.gypi' ], # brings in a default set of options that are inherited from gyp
  'variables': { # custom variables we use specific to this file
      'error_on_warnings%':'true', # can be overriden by a command line variable because of the % sign using "WERROR" (defined in Makefile)
      # Use this variable to silence warnings from mason dependencies and from node-addon-api
      # It's a variable to make easy to pass to
      # cflags (linux) and xcode (mac)
      'system_includes': [
        "-isystem <!@(node -p \"require('node-addon-api').include.slice(1,-1)\")",
        "-isystem <(module_root_dir)/mason_packages/.link/include/"
      ],
      'compiler_checks': [
        '-Wall',
        '-Wextra',
        '-Wconversion',
        '-pedantic-errors',
        '-Wconversion',
        '-Wshadow',
        '-Wfloat-equal',
        '-Wuninitialized',
        '-Wunreachable-code',
        '-Wold-style-cast',
        '-Wno-error=unused-variable',
        '-Wno-error=deprecated-declarations'
      ]
  },
  # `targets` is a list of targets for gyp to run.
  # Different types of targets:
  # - [executable](https://github.com/mapbox/cpp/blob/master/glossary.md#executable)
  # - [loadable_module](https://github.com/mapbox/cpp/blob/master/glossary.md#loadable-module)
  # - [static library](https://github.com/mapbox/cpp/blob/master/glossary.md#static-library)
  # - [shared library](https://github.com/mapbox/cpp/blob/master/glossary.md#shared-library)
  # - none: a trick to tell gyp not to run the compiler for a given target.
  'targets': [
    {
      'target_name': 'action_before_build',
      'type': 'none',
      'hard_dependency': 1,
      'actions': [
        # {
        #   'action_name': 'install_deps',
        #   'inputs': ['./node_modules/.bin/mason-js'],
        #   'outputs': ['./mason_packages'],
        #   'action': ['./node_modules/.bin/mason-js', 'install']
        # },
        # {
        #   'action_name': 'link_deps',
        #   'inputs': ['./node_modules/.bin/mason-js'],
        #   'outputs': ['./mason_packages/.link'],
        #   'action': ['./node_modules/.bin/mason-js', 'link']
        # }
      ]
    },
    {
      # module_name and module_path are both variables passed by node-pre-gyp from package.json
      'target_name': '<(module_name)', # sets the name of the binary file
      'product_dir': '<(module_path)', # controls where the node binary file gets copied to (./lib/binding/module.node)
      'type': 'loadable_module',
      'dependencies': [ 'action_before_build' ],
      # "make" only watches files specified here, and will sometimes cache these files after the first compile.
      # This cache can sometimes cause confusing errors when removing/renaming/adding new files.
      # Running "make clean" helps to prevent this "mysterious error by cache" scenario
      # This also is where the benefits of using a "glob" come into play...
      # See: https://github.com/mapbox/node-cpp-skel/pull/44#discussion_r122050205
      'include_dirs': [
        '.\\node_modules\\node-addon-api\\',
        '.\\mason_packages\\',
      ],
      "defines": [
        "NAPI_CPP_EXCEPTIONS"
      ],
      "msvs_toolset": "v142",
      'sources': [
        './src/module.cpp',
        './src/vtquery.cpp'
      ],
      'ldflags': [
        '-Wl,-z,now',
      ],
      'conditions': [
        ['error_on_warnings == "true"', {
            'cflags_cc' : [ '-Werror' ],
            'xcode_settings': {
              'OTHER_CPLUSPLUSFLAGS': [ '-Werror' ]
            }
        }]
      ],
      'cflags': [
          '<@(system_includes)',
          '<@(compiler_checks)'
      ],
      'xcode_settings': {
        'OTHER_LDFLAGS':[
          '-Wl,-bind_at_load'
        ],
        'OTHER_CPLUSPLUSFLAGS': [
            '<@(system_includes)',
            '<@(compiler_checks)'
        ],
        'GCC_ENABLE_CPP_RTTI': 'YES',
        'GCC_ENABLE_CPP_EXCEPTIONS': 'YES',
        'MACOSX_DEPLOYMENT_TARGET':'10.8',
        'CLANG_CXX_LIBRARY': 'libc++',
        'CLANG_CXX_LANGUAGE_STANDARD':'c++14',
        'GCC_VERSION': 'com.apple.compilers.llvm.clang.1_0'
      }
    }
  ]
}
