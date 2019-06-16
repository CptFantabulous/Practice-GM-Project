//argument0 node ID to colour
//argument1 selected actors move
//argument2 selectedActors actions

var move, node, actions

node = argument0
move = argument1
actions = argument2

if(actions > 1)
{
    if(node.G > move)
    {
        node.colour = c_yellow
    }
    else
    {
        node.colour = c_aqua
    }
}
else
{
    node.colour = c_yellow
}
