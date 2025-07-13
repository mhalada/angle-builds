{
  'targets': [
    {
      'target_name': 'canvas',
      'sources': [
        'src/backend/Backend.cc',
        'src/backend/ImageBackend.cc',
        'src/backend/PdfBackend.cc',
        'src/backend/SvgBackend.cc',
        'src/bmp/BMPParser.cc',
        'src/Backends.cc',
        'src/Canvas.cc',
        'src/CanvasGradient.cc',
        'src/CanvasPattern.cc',
        'src/CanvasRenderingContext2d.cc',
        'src/closure.cc',
        'src/color.cc',
        'src/Image.cc',
        'src/ImageData.cc',
        'src/init.cc',
        'src/register_font.cc',
        'src/FontParser.cc'
      ],
      'defines': [
        'HAVE_GIF',
        'HAVE_JPEG',
        'HAVE_RSVG',
        'HAVE_BOOLEAN', # or jmorecfg.h tries to define it
        '_USE_MATH_DEFINES', # for M_PI
        'NOMINMAX', # allow std::min/max to work
        'NAPI_DISABLE_CPP_EXCEPTIONS',
        'NODE_ADDON_API_ENABLE_MAYBE'
      ],
      'libraries': [
        'C:/vcpkg/installed/arm64-windows/lib/cairo.lib',
        'C:/vcpkg/installed/arm64-windows/lib/pangocairo.lib',
        'C:/vcpkg/installed/arm64-windows/lib/libpng16.lib',
        'C:/vcpkg/installed/arm64-windows/lib/gobject-2.0.lib',
        'C:/vcpkg/installed/arm64-windows/lib/glib-2.0.lib',
        'C:/vcpkg/installed/arm64-windows/lib/freetype.lib',
        'C:/vcpkg/packages/libjpeg-turbo_arm64-windows/lib/libjpeg-8.lib',
        'C:/vcpkg/packages/pango_arm64-windows/lib/libpango-1.0-0.lib',
        'C:/vcpkg/packages/libjpeg-turbo_arm64-windows/lib/libturbojpeg.lib',
        'C:/vcpkg/packages/giflib_arm64-windows/lib/libgif-7.lib',
        'C:/vcpkg/packages/librsvg_arm64-windows/lib/librsvg-2-2.lib',
        # 'C:/a/_temp/msys64/clangarm64/lib/libcairo-2.lib',
        # 'C:/a/_temp/msys64/clangarm64/lib/libpng16-16.lib',
        # 'C:/a/_temp/msys64/clangarm64/lib/libjpeg-8.lib',
        # 'C:/a/_temp/msys64/clangarm64/lib/libpango-1.0-0.lib',
        # 'C:/a/_temp/msys64/clangarm64/lib/libpangocairo-1.0-0.lib',
        # 'C:/a/_temp/msys64/clangarm64/lib/libgobject-2.0-0.lib',
        # 'C:/a/_temp/msys64/clangarm64/lib/libglib-2.0-0.lib',
        # 'C:/a/_temp/msys64/clangarm64/lib/libturbojpeg.lib',
        # 'C:/a/_temp/msys64/clangarm64/lib/libgif-7.lib',
        # 'C:/a/_temp/msys64/clangarm64/lib/libfreetype-6.lib',
        # 'C:/a/_temp/msys64/clangarm64/lib/librsvg-2-2.lib'
      ],
      'include_dirs': [
        '<!(node -p "require(\'node-addon-api\').include_dir")',
        'C:/a/_temp/msys64/clangarm64/include',
        'C:/a/_temp/msys64/clangarm64/include/harfbuzz',
        'C:/a/_temp/msys64/clangarm64/include/pango-1.0',
        'C:/a/_temp/msys64/clangarm64/include/cairo',
        'C:/a/_temp/msys64/clangarm64/include/libpng16',
        'C:/a/_temp/msys64/clangarm64/include/glib-2.0',
        'C:/a/_temp/msys64/clangarm64/lib/glib-2.0/include',
        'C:/a/_temp/msys64/clangarm64/include/pixman-1',
        'C:/a/_temp/msys64/clangarm64/include/freetype2',
        'C:/a/_temp/msys64/clangarm64/include/fontconfig',
        'C:/a/_temp/msys64/clangarm64/include/librsvg-2.0',
        'C:/a/_temp/msys64/clangarm64/include/gdk-pixbuf-2.0',
        'C:/a/_temp/msys64/clangarm64/include/libgsf-1' # NEW
      ],
      'configurations': {
        'Debug': {
          'msvs_settings': {
            'VCCLCompilerTool': {
              'WarningLevel': 4,
              'ExceptionHandling': 1,
              'DisableSpecificWarnings': [4100, 4127, 4201, 4244, 4267, 4506, 4611, 4714, 4512]
            }
          }
        },
        'Release': {
          'msvs_settings': {
            'VCCLCompilerTool': {
              'WarningLevel': 4,
              'ExceptionHandling': 1,
              'DisableSpecificWarnings': [4100, 4127, 4201, 4244, 4267, 4506, 4611, 4714, 4512]
            }
          }
        }
      }
    }
  ]
}