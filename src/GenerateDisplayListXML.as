//	Copyright Wayne Marsh 2010 (http://marshgames.com/)
//	
//	This file is part of SWFToXML.
//	
//	SWFToXML is free software: you can redistribute it and/or modify
//	it under the terms of the GNU General Public License as published by
//	the Free Software Foundation, either version 3 of the License, or
//	(at your option) any later version.
//	
//	SWFToXML is distributed in the hope that it will be useful,
//	but WITHOUT ANY WARRANTY; without even the implied warranty of
//	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//	GNU General Public License for more details.
//	
//	You should have received a copy of the GNU General Public License
//	along with SWFToXML.  If not, see <http://www.gnu.org/licenses/>.

package 
{
	import flash.display.DisplayObjectContainer;
	
	function GenerateDisplayListXML(root:DisplayObjectContainer, recurse:Boolean):XML
	{
		var xml:XML = <array />;
		
		xml.appendChild(ProcessNode(root, recurse));
		
		return xml;
	}
}

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.utils.getQualifiedClassName;

function ProcessNode(node:DisplayObjectContainer, recurse:Boolean):XML
{
	var children:XML = <array />;
	
	var xml:XML = GenerateDisplayObjectXML(node);
	xml.appendChild(<key>children</key>);
	xml.appendChild(children);
	
	for (var i:int = 0; i < node.numChildren; i++)
	{
		var child:DisplayObject = node.getChildAt(i);
		if (child is DisplayObjectContainer && recurse)
		{
			children.appendChild(ProcessNode(DisplayObjectContainer(child), true));
		}
		else
		{
			children.appendChild(GenerateDisplayObjectXML(child));
		}
	}
	
	return xml;
}

function GenerateDisplayObjectXML(d:DisplayObject):XML
{
	var xml:XML = <dict />;
	
	xml.appendChild(<key>name</key>);
	xml.appendChild(<string>{d.name}</string>);
	xml.appendChild(<key>className</key>);
	xml.appendChild(<string>{getQualifiedClassName(d)}</string>);
	xml.appendChild(<key>matrix</key>);
	xml.appendChild(<string>{d.transform.matrix}</string>);
	xml.appendChild(<key>x</key>);
	xml.appendChild(<string>{d.x}</string>);
	xml.appendChild(<key>y</key>);
	xml.appendChild(<string>{d.y}</string>);
	xml.appendChild(<key>rotation</key>);
	xml.appendChild(<string>{d.rotation}</string>);
	
//	xml.@name = d.name;
//	xml.@className = getQualifiedClassName(d);
//	xml.@matrix = d.transform.matrix.toString();
//	xml.@x = d.x;
//	xml.@y = d.y;
	
	return xml;
}