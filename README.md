# .root to .gltf exporter

> The following is a tool that can be used to load .root files that describe a particular geometry and then export that geometry to a whole .gltf file or multiple parts (multiple .gltf files) of that particular geometry. 

## 🥱 Dependencies nodejs, npm, jsroot 

For the exporter to work properly you need to have installed [jsroot](https://github.com/root-project/jsroot) on your machine and to get it you either follow the instructions below or simply install nodejs and the npm package manager (**recommended**) and then run the `setup.sh` script which simply goes into the `jsroot` directory of this project and runs: ``` npm install ``` and then you should be good to go.

## ⬇️ Installing npm (node package manager)

Best way to get the lastest versions of nodejs and npm is to use `nvm`
 - Follow the below instructions and in the end you should have everything needed in your system.

### About
nvm is a version manager for [node.js](https://nodejs.org/en/), designed to be installed per-user, and invoked per-shell. `nvm` works on any POSIX-compliant shell (sh, dash, ksh, zsh, bash), in particular on these platforms: unix, macOS, and windows WSL.

### Install & Update Script

To **install** or **update** nvm, you should run the [install script]

```sh
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
```
```sh
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
```

Running either of the above commands downloads a script and runs it. The script clones the nvm repository to `~/.nvm`, and attempts to add the source lines from the snippet below to the correct profile file (`~/.bash_profile`, `~/.zshrc`, `~/.profile`, or `~/.bashrc`).

<a id="profile_snippet"></a>
```sh
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
```

#### Additional Notes

- If the environment variable `$XDG_CONFIG_HOME` is present, it will place the `nvm` files there.</sub>

- You can add `--no-use` to the end of the above script (...`nvm.sh --no-use`) to postpone using `nvm` until you manually [`use`](#usage) it.

- You can customize the install source, directory, profile, and version using the `NVM_SOURCE`, `NVM_DIR`, `PROFILE`, and `NODE_VERSION` variables.
Eg: `curl ... | NVM_DIR="path/to/nvm"`. Ensure that the `NVM_DIR` does not contain a trailing slash.

- The installer can use `git`, `curl`, or `wget` to download `nvm`, whichever is available.

#### Troubleshooting on Linux

On Linux, after running the install script, if you get `nvm: command not found` or see no feedback from your terminal after you type `command -v nvm`, simply close your current terminal, open a new terminal, and try verifying again.
Alternatively, you can run run the following commands for the different shells on the command line:

*bash*: `source ~/.bashrc`

*zsh*: `source ~/.zshrc`

*ksh*: `. ~/.profile`

These should pick up the `nvm` command.

### Verify Installation

To verify that nvm has been installed, do:

```sh
command -v nvm
```

which should output `nvm` if the installation was successful. Please note that `which nvm` will not work, since `nvm` is a sourced shell function, not an executable binary.

## Installing node with nvm

To get the latest LTS version of node and migrate your existing installed packages, use

```sh
nvm install 'lts/*' --reinstall-packages-from=current
```

Then you should have the latest and stable version of nodejs on your system as long as the npm package manager that comes with it. 

### Verify installations: 

```sh
$ node -v

$ npm -v
```

At this point you're good to go and ready to run the `setup.sh` script which will install jsroot and finally you're ready to use the exporter.

## ⬇️ Installing JSROOT

In most practical cases it is not necessary to install JSROOT - it can be used directly from project web sites <https://root.cern/js/> and <https://jsroot.gsi.de/>.

When required, there are following alternatives to install JSROOT on other web servers:

   - download and unpack [provided](https://github.com/root-project/jsroot/releases) packages (recommended)
   - use [npm](https://npmjs.com/package/jsroot) package manager and invoke `npm install jsroot`
   - clone master branch from [repository](https://github.com/root-project/jsroot/)

One could use JSROOT directly from local file system. If source code was unpacked/checked-out in `/home/user/jsroot/` subfolder, one could just open it in browser with <file:///home/user/jsroot/index.htm> address.


## 🧰 Using the exporter 

The file you're interested in is the `export.html` file. 
Once you open that one you'll see that it is written such that it seems to be specific to the LHCb experiment. But it's not. You can modify what will be showcased bellow so you could adapt it to your own experiment and needs. 

## 👣 Steps 

 1. Load your own root file: 

```html
<!-- Head to the line 186 of the exporter and you will see the following: -->

var filename = "https://root.cern/files/lhcbfull.root"
    JSROOT.openFile(filename)
    .then(file => file.readObject("Geometry;1"))
    .then(obj => add_geometry(obj));

<!-- What you need to change here is the filename obviously, it can be either a link as the example, or a local file that you will import to the project, for example you can create a directory called: root_files and add your file there and then you can update the var filename as follows: -->

var filename = "./root_files/my_root_file.root";

<!-- In any case the provided string must be a file that ends with a .root extension. -->
```

 2. Run the exporter. 

By default when you simply load your own root file and run the exporter you should get a .gltf file as output that describes your whole geometry provided from the root file into a (you guessed it) .gltf file.

 3. Open your gltf file and see it in action. 

Using the following tool -> [gltf_viewer](https://gltf-viewer.donmccurdy.com/) you can import and open your .gltf file and you should see your geometry rendered and displayed properly on the screen. Apart from that if you open the browser's developer tools and then go to the `console` tab you should see all the meshes displayed there in strings and those string labels will be very useful to you in order to use them properly to hide different parts of your geometry and export multiple .gltf files that describe those seperated parts, but all together describe your whole geometry. Those string labels in the console are the exactly same strings that are used in your root file to describe all the parts of your geometry and can be seen by importing the root file itself to the following tool -> [root_viewer](https://jsroot.gsi.de/latest/). 

 4. Using the below described string labels to generate multiple .gltf files of different subparts of your geometry. 

You can have a look on the results directory of this project to see the multiple generated .gltf files that describe the LHCb geometry as well as the whole LHCb geometry from the 1 .gltf file labeled as `LHCb_run3_full.gltf`. If you open those gltf files with the gltf_viewer tool mentioned above and check the console you should see the following strings displayed: 

```javascript
var to_hide = [
            "_dd_Structure_LHCb_MagnetRegion_Magnet_UpperCoil0x18b2fdb0", "_dd_Structure_LHCb_MagnetRegion_Magnet_LowerCoil0x18b2fe80",
            "_dd_Structure_LHCb_MagnetRegion_Magnet_Left_Vertical_Part0x18b2eef0",
            "_dd_Structure_LHCb_MagnetRegion_Magnet_Right_Vertical_Part0x18b2ef50",
            "_dd_Structure_LHCb_MagnetRegion_Magnet_Upper_Horizontal_Part0x18b2bd10",
            "_dd_Structure_LHCb_MagnetRegion_Magnet_Lower_Horizontal_Part0x18b2be40"
        ];

        var hide_children = [
            "_dd_Structure_LHCb_DownstreamRegion_Ecal0x18c35b20", "_dd_Structure_LHCb_DownstreamRegion_Hcal0x18c702d0",
            "_dd_Structure_LHCb_DownstreamRegion_Muon_pvMuonBack0x18303210", "_dd_Structure_LHCb_BeforeMagnetRegion_Rich10x18b29c90",
            "_dd_Structure_LHCb_BeforeMagnetRegion_VP0x183fd6f0", "_dd_Structure_LHCb_BeforeMagnetRegion_UT0x184c8430", "_dd_Structure_LHCb_AfterMagnetRegion_Rich20x1934e2d0",
            "_dd_Structure_LHCb_AfterMagnetRegion_T_FT0x191249b0"
        ];
```

And now, if you head to our exporter on the lines: 39 to 61 you'll find the following lines of code: 

```javascript
/**
         * Uncomment the following arrays to hide the parts that you need. 
         * You can remove specific strings from the arrays to hide specific parts!
         */

        // var to_hide = [
        //     "MagnetYoke", "ITlvAirVolume", "VeloVacTank", "VeloRFBox",
        //     "VeloRFFoil", "PipeSection", "Rich1lvRich1Mgs", "Rich1lvRich1MagSh", "Rich1lvRich1Exit",
        //     "Velo2Rich", "Rich2lvRich2MagSh", "Rich2lvRich2Tube", "MagnetCoil_4844", "VeloSupports", "VeloSensors",
        //     "OTModules", "ITITS3", "Rich1lvRich1", "ITITS1l", "VeloWFConel", "ITITS2lv", "ITITS", "Rich1l", "Rich2l",
        //     "PrsInstallation", "PrsSteelSheet", "SpdInstallation"
        // ];

        // var hide_children = [];

        // var hide_EcalHcal = [
        //     "EcalInstallation", "HcalInstallation"
        // ];

        // var hide_muon = [
        //     "Muon"
        // ];
```

Basically what you need to do in order to start generating different parts of your geometry is to find all the volumes (labels / strings) that we where talking about above from the console of the gltf_viewer that make up your whole geometry and place them one by one into the `to_hide` variable replacing the already existing strings (that are specific to LHCb). Keep in mind that you don't need to get each and every one of them, just only the parent nodes of the tree that make up the whole geometry. For example, if you see the `hide_EcalHcal` variable above, you'll notice that it contains: `"EcalInstallation", "HcalInstallation"`. Those 2 are parents of the Ecal, Hcal subdetectors of the whole LHCb detector and they include even much more nodes inside of them, but by using only these 2 we can hide the whole thing. 

After you've found out all your volumes and you put them inside the `to_hide` array, if you run the exporter you should see nothing displayed when you load your gltf file to the gltf_viewer. Then I think it's trivial on how you can get each of the parts. You just uncomment / comment each time the particular part that you want to export and run the exporter many times to gather all your components! 

> Note! 

As seen above on the code example, we have the variables 

```
var hide_EcalHcal = []; 

var hide_muon = []; 
```

The purpose of them is just to make it a bit clearer on the different parts that you want to hide and not gather all of your strings into the `to_hide` variable. 
But in order for them to work you need to add a for loop for each of them you create. See the example below for the above 2 variables: 

```javascript
// lines 62-112 of the export.html file

function process_root_node(node, level = 0, path = "") {
            //mylog.innerHTML += path + " " +  level + " " + node.fName + "\n";

            tmpname = node.fName;
            iterate_children = true;
            //console.log("processing:", tmpname, path, node)

            for (let i = 0; i < to_hide.length; i++) {
                item = to_hide[i];
                //console.log("Checking:", item);
                if (tmpname.startsWith(item)) {
                    node.fVolume.fGeoAtt = 0;
                }
            }

            // Hide Ecal, Hcal
            for (let i = 0; i < hide_EcalHcal.length; i++) {
                item = hide_EcalHcal[i];
                //console.log("Checking:", item);
                if (tmpname.startsWith(item)) {
                    node.fVolume.fGeoAtt = 0;
                }
            }

            // Hide Muon
            for (let i = 0; i < hide_muon.length; i++) {
                item = hide_muon[i];
                //console.log("Checking:", item);
                if (tmpname.startsWith(item)) {
                    node.fVolume.fGeoAtt = 0;
                }
            }

            for (let i = 0; i < hide_children.length; i++) {
                item = hide_children[i];
                //console.log("Checking:", item);
                if (tmpname.startsWith(item)) {
                    node.fVolume.fGeoAtt = 0;
                    iterate_children = false;
                    //console.log("Matched", item, tmpname, path)
                }
            }

            //console.log("subvolume:", tmpname, node);
            if (node.fVolume.fNodes && iterate_children) {
                for (let j = 0; j < node.fVolume.fNodes.arr.length; j++) {
                    snode = node.fVolume.fNodes.arr[j];
                    process_root_node(snode, level + 1, path + "/" + tmpname);
                }
            }
        }
```

And that's it! 🥂