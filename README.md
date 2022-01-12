# ThinfinityX-Tag
Simple example of an X-Tag component.<br>
As of 2022-01-12, using Thinfinity VirtualUI v 3.0.7.108, it looks like you cannot use JSRO and "VirtualUI.SendMessage" together.<br>
This sample app does not work.<br>
If you comment out the startJsRO(this.id) call in orion-code.js, then the "VirtualUI.SendMessage" code works.<br>
Maybe I am doing something a bit wrong in this app, or maybe it is a bug in the Thinfinity VirtualUI system.<br>
