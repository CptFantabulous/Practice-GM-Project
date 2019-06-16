//argument0 = orgin node the node we are pathfinding from
//argument1 = units movement range
//argument2 = units remaining actions

//reset all node data
Wipe_Nodes()

var open, closed  //arrays for holding checked and unchecked nodes
var start, current, neighbors //these hold instance IDs
var tempG, range, costMod

//declare relevant varaubes from arguments 

start = argument0
range = argument1 * argument2

//create data structures

open = ds_priority_create()
closed = ds_list_create()

//add starting node to the open list

ds_priority_add(open, start, start.G)

//while open cue is not empty repeat the following code until all nodes have been checked

while(ds_priority_size(open))
{
    //remove node with the lowest G score from open
    current = ds_priority_delete_min(open)
    //add that node to the closed list
    ds_list_add(closed, current)
    
    //step through all of currents neighborss
    for(ii = 0; ii < ds_list_size(current.neighbors); ii++)
    {
        //store current neighbors in neighbors variable
        neighbors = ds_list_find_value(current.neighbors, ii)
        
        //add neighbors to open list if it qualifies
        //neighbors must be passable
        //neighbors must have no occupant
        //neighborss projects G score is less than movement range
        //neighbors isn't already on the closed list
        
        if(ds_list_find_index(closed, neighbors) < 0 && neighbors.passable && neighbors.occupant = noone && current.G <= range)
        {
            //only calculate a new G score for neighbors if it hasn't already been calculated
            if(ds_priority_find_priority(open, neighbors) == 0 || ds_priority_find_priority(open, neighbors) == undefined)
            {
                costMod = 1
                //give neighbors the right parent
                neighbors.parent = current
                //if node is diagonal create appropriate costMode
                if(neighbors.gridX != current.gridX && neighbors.gridY != current.gridY)
                {
                    costMod = 1.5
                }
                //calculate G score of neighbors with costMod in place
                neighbors.G = current.G + (neighbors.cost * costMod)
                
                //add to the open list
                ds_priority_add(open, neighbors,neighbors.G)
            }
            else //else if neighborss score has already been calced then we are going to recalculate it if it fits
            {
                costMod = 1
                //figure out if the neighborss score would be lower if found from the current node
                //if node is diagonal create appropriate costMode
                if(neighbors.gridX != current.gridX && neighbors.gridY != current.gridY)
                {
                    costMod = 1.5
                }
                tempG = current.G + (neighbors.cost * costMod)
                //check if G score  would be lower
                if(tempG < neighbors.G)
                {
                    neighbors.parent = current
                    neighbors.G = tempG
                    ds_priority_change_priority(open, neighbors, neighbors.G)
                }
            }
        } 
    }
}

//round down all G scores for movement calculations 
with(oNode)
{
    G = floor(G)
}

//tidy away the memory for the open 
ds_priority_destroy(open)
 //colour all the nodes and then get rid of the closed list
 
 for(ii = 0; ii < ds_list_size(closed); ii++)
 {
    current = ds_list_find_value(closed, ii)
    current.moveNode = true
    Colour_Move_Nodes(current, argument1, argument2)
    
 }
 
 //destroy the closed list
 ds_list_destroy(closed)
