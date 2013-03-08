# include once "ext/math.bi"

dim as ext.math.vec4f my4
dim as ext.math.vec3f my3


my4.x = 1
my4.y = 2
my4.z = 3
my4.w = 23

print my4

my4 = my4 + my4

print my4

my3 = my4
print my3
