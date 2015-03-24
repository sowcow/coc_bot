require 'pathname'
require 'yaml'

# actually target assets or so - images and coordinates....
class Assets

  def initialize dir
    dir = Pathname dir

    images = dir + '*.png'
    Pathname.glob(images) { |file|
      name = file.basename.to_s.sub(file.extname, '')

      define_singleton_method name do
        file.to_s
      end
    }

    yamls = dir + '*.yml'
    Pathname.glob(yamls) { |file|
      hash = YAML.load_file file
      hash.each_pair { |name, point|

        #name = name + '!' # raw coords - must be sure
        #                # it is in the right state
        #              # or it can click anything at all

        define_singleton_method name do
          point  # no preprocessing here
        end
      }
    }
  end
end
