# DisPlayers-Audio-Visualizers

[![CI Status](http://img.shields.io/travis/liptugamichael@gmail.com/DisPlayers-Audio-Visualizers.svg?style=flat)](https://travis-ci.org/liptugamichael@gmail.com/DisPlayers-Audio-Visualizers)
[![Version](https://img.shields.io/cocoapods/v/DisPlayers-Audio-Visualizers.svg?style=flat)](http://cocoapods.org/pods/DisPlayers-Audio-Visualizers)
[![License](https://img.shields.io/cocoapods/l/DisPlayers-Audio-Visualizers.svg?style=flat)](http://cocoapods.org/pods/DisPlayers-Audio-Visualizers)
[![Platform](https://img.shields.io/cocoapods/p/DisPlayers-Audio-Visualizers.svg?style=flat)](http://cocoapods.org/pods/DisPlayers-Audio-Visualizers)

# DisPlayers-Audio-Visualizers
DisPlayer is a customizable audio visualization component that works with recording and playing back audio files

![Histogram Demo](https://cloud.githubusercontent.com/assets/11332192/24103061/c3197d9c-0d86-11e7-8563-335eb32e7a75.gif)
![Wave Demo](https://cloud.githubusercontent.com/assets/11332192/24104119/0ad9faaa-0d8a-11e7-9889-31f5df7a8648.gif)
![WaveStroke Demo](https://cloud.githubusercontent.com/assets/11332192/24104353/b4151578-0d8a-11e7-95f1-d267fab0ac49.gif)


The audio visualizer can be easily embedded into an app that features:
* audio comments to text or multimedia posts
* recording and sending audio files in a chat
* playing back audio files posted in a chat using a dedicated UI component

DisPlayer features 5 default visualization presets that can be customized by the background color (single tone or gradient), the wave color, the number of the wave’s bins/bars, and the wave amplitude.

## Installation

The control can be easily embedded into an app:
 
——здесь будет код------------ 

Import the Equalizer.h class and create the AudioSettings object with the parameters for the chosen control type:

——здесь будет код------------

Some presets display audio frequencies as a separate waves, which provides more possibilities for cool sound visualization for your project.

## Usage

CocoaPods is the recommended way to add DisPlayer to your project:
 
 1. Add a pod entry for DisPlayer to your Podfile pod 'DisPlayer'
 2. Install the pod(s) by running pod installation.
 3. Include DisPlayer wherever you need it with #import «Equalizers.h».

## Requirements

DisPlayer works on iOS 8.0+ and is compatible with ARC projects.
It depends on the following Apple frameworks, which should already be included with most Xcode templates:
CoreGraphics.framework
QuartzCore.framework 
CoreAudio.framework 
You will need LLVM 3.0 or later in order to build “DisPlayer”

## Author

This library is open-sourced by Agilie Team

## License

The MIT License (MIT) Copyright © 2017 Agilie Team
