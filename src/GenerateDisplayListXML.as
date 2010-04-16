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
	
	function GenerateDisplayListXML(root:DisplayObjectContainer):XML
	{
		var xml:XML = <DisplayList />;
		
		xml.DisplayList += ProcessNode(root);
		
		return xml;
	}
}

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.utils.getQualifiedClassName;

function ProcessNode(node:DisplayObjectContainer):XML
{
	var xml:XML = GenerateDisplayObjectXML(node);
	
	for (var i:int = 0; i < node.numChildren; i++)
	{
		var child:DisplayObject = node.getChildAt(i);
		if (child is DisplayObjectContainer)
		{
			xml.DisplayObject += ProcessNode(DisplayObjectContainer(child));
		}
		else
		{
			xml.DisplayObject += GenerateDisplayObjectXML(child);
		}
	}
	
	return xml;
}

function GenerateDisplayObjectXML(d:DisplayObject):XML
{
	var xml:XML = <DisplayObject />;
	
	xml.@name = d.name;
	xml.@className = getQualifiedClassName(d);
	xml.@matrix = d.transform.matrix.toString();
	xml.@x = d.x;
	xml.@y = d.y;
	
	return xml;
}