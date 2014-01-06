''File: 2drotate.bas
''Description: Demonstration of rotation using vectors and matrices.
''
''Copyright (c) 2007-2014 FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. (See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License)

# include once "ext/graphics.bi"
# include once "ext/math/matrix.bi"
# include once "fbgfx.bi"

using ext.math
randomize timer

type line_struct
    index(1 to 2) as integer ' the index into the "vertices" array of our model
end type

type obj_struct
    max_vertices    as integer 'the number of vertices in our model
    max_lines       as integer 'the number of lines in our model
    vertices        as vec2f ptr 'the vertex array
    tvertices       as vec2f ptr 'secondary array for transformed vertices
    lines           as line_struct ptr 'used to store indexed vertices
end type


const as integer SCR_W = 640 'screen resolution width
const as integer SCR_H = 480 'screen resolution height

screenres SCR_W,SCR_H,16

dim as obj_struct obj 'create our initial 2d object

read obj.max_vertices 'we're storing our object with data statements,
                      'so we read the number of vertices first.
obj.vertices  = new vec2f[obj.max_vertices]
obj.tvertices = new vec2f[obj.max_vertices]

'our object is a little small, so we need to scale it up a bit.
'this demonstrates how to scale the object using an ext.matrix
'a value of 1 will actually do nothing, 100% scale, in otherwords
'1.5 will scale it up by 150%,
'2 will scale by 200%, etc...
dim as matrix init_matrix
init_matrix.LoadIdentity
init_matrix.Scale(1.5)

for i as integer = 0 to obj.max_vertices-1
    dim as single tx, ty' temporary floats to load the data into
    read tx, ty' now we actually read that vertex data

    'now to multiply the vertex with the init matrix and store it in our model's "vertices" array
    obj.vertices[i] = vec2f(tx,ty) * init_matrix
next


read obj.max_lines 'again with the data statements... we need to know how many lines there are
obj.lines = new line_struct[obj.max_lines]

for i as integer = 0 to obj.max_lines-1
    dim as integer p1, p2'temporary integers to hold the indices
    read p1, p2' read the actual index data

    'since our arrays are 0 based, we need to subtract one from the index data
    'this is actually the connectivity data for the model.
    'ie, we draw a line from p1 to p2...
    obj.lines[i].index(1) = p1-1
    obj.lines[i].index(2) = p2-1
next

dim as integer angle, mousex, mousey, button
dim as vec2f position = vec2f(320, 240)'the position vector for the ship
dim as vec3f velocity'the velocity(direction) vector of the ship
dim as single thrust'this is just a scalar that we will use to scale the speed of the ship

do
    'this section just takes the current position of the mouse and
    'the current position of the ship, and finds the angle needed
    'to rotate the ship to point at the mouse position
    getmouse(mousex, mousey,, button)
    angle = atan2( mousey-position.y, mousex-position.x ) * inv_pi_180

    'this section creates a matrix for our ship,
    'initializes it to identity, which you can think of as a matrix with 0 position,
    '0 rotation and a scale of 1.0.
    dim as matrix ship_matrix
    ship_matrix.LoadIdentity

    'now we're translating the matrix to the ship's position,
    'and rotating to the desired angle.
    ship_matrix.Translate(position.x, position.y, 0)
    ship_matrix.Rotate(0,0,angle)

    'if the mouse button is down, we increment the thrust variable
    'we're clamping it to 10 so that the ship doesn't move too fast.
    'also, we copy the ship matrix "right" vector to the velocity vector
    'we're using the "right" vector because this is a 2d representation
    'and we only need to worry about the z axis rotation
    'if the mouse button isn't down, we just decrement the thrust variable.
    if button and 1 then
        thrust+=.1
        if thrust>10 then thrust = 10
        velocity = ship_matrix.right
    else
        thrust*=.975
    end if

    'here we just multiply the velocity with the thrust vector
    'and add it to the ship's position
    'not a realistic simulation, but it works for this demo ;)
    var __tempv3f = velocity*thrust
    position+= vec2f(__tempv3f.x,__tempv3f.y)


    'transform the vertices using ship_matrix
    'we're also storing them in the object's tvertices array
    for i as integer = 0 to obj.max_vertices-1
        obj.tvertices[i] = obj.vertices[i]*ship_matrix
    next

    screenlock
    cls

    'we're just printing the integer angle of the ship... for no real reason
    locate 1,1
    print ABS(angle-360) mod 360

    'we draw the object here
    'since we stored the transformed vertices in the object's tvertices array,
    'we're just using that to draw the lines
    'this method doesn't require us to do any calculations within the drawing loop
    for l as integer = 0 to obj.max_lines-1
        dim as vec2f p1 = obj.tvertices[ obj.lines[l].index(1) ]
        dim as vec2f p2 = obj.tvertices[ obj.lines[l].index(2) ]
        line(p1.x, p1.y)-(p2.x, p2.y), rgb(128,128,128)
    next

    screensync
    screenunlock
    sleep 1,1

loop until multikey(FB.SC_ESCAPE)

'clean up the memory we used
delete[] obj.vertices
delete[] obj.tvertices
delete[] obj.lines

'vertex count first
data 29
'list of vertices
data 5.9, -3.01101e-011
data 5.9, -1.58
data 8.7, -1.58
data 8.7, -3.2
data 4.7, -5
data 3.7, -5.8
data 2.1, -7.4
data -0.6, -8.2
data -3.3, -8.2
data -5.7, -7
data -7.9, -4.6
data -8.5, -2
data -8.7, 4.43997e-011
data 5.9, 1.58
data 8.7, 1.58
data 8.7, 3.2
data 4.7, 5
data 3.7, 5.8
data 2.1, 7.4
data -0.6, 8.2
data -3.3, 8.2
data -5.7, 7
data -7.9, 4.6
data -8.5, 2
data 5.7, 5.8
data 6.5, 6
data 6.5, 7
data 5.7, 7.2
data 4.1, 7.2

'line index count first
data 29
'list of indices into the vertex array
data 28, 29
data 27, 28
data 26, 27
data 25, 26
data 18, 25
data 17, 18
data 16, 17
data 15, 16
data 14, 15
data 1, 14
data 2, 1
data 3, 2
data 4, 3
data 5, 4
data 6, 5
data 7, 6
data 8, 7
data 9, 8
data 10, 9
data 11, 10
data 12, 11
data 13, 12
data 24, 13
data 23, 24
data 22, 23
data 21, 22
data 20, 21
data 19, 20
data 29, 19
