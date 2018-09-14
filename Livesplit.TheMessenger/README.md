# LiveSplit.TheMessenger
Autosplitter for the game The Messenger

## Installing
  * Open LiveSplit
  * Edit your splits
  * Set the game to The Messenger
  * Click Activate autosplitter
  
## Splits
  * Starts on confirming the file name
  * Splits :
    * Start a level
    * Beat a boss
    * Obtain an item (items, upgrades, phobekins, music notes)
    * End a cutscene
    * Break a Power Seal
    
## Room Timer
First, in the autosplitter you need to check the last setting 'Individual Room Timer'

Then you need to download and copy this component into the Components directory of Livesplit to be able to see the variables from the autosplitter : https://github.com/hawkerm/LiveSplit.ASLVarViewer

After closing and re-opening Livesplit you will be able to add the new component in the layout editor.</br>
Add the component 'Information -> Asl Var Viewer' twice.</br>
Edit the two components by giving them a name (or not) and check the 'Variables' checkboxes.</br>
In the droplist choose 'actualRoomTime' for one of the component and 'previousRoomTime' for the other one.

WARNINIG : If you use the room timer you'll need to load at least a save since the launch of the game window otherwise the autosplitter will not work.