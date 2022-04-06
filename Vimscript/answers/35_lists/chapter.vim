" lists

:let list1 = ["foo", 3, "bar"]
:echo list1
:echo list1[0]
:echo list1[1]
:echo list1[2]

:let list2 = ["foo", [3, "bar"]]
:echo list2
:echo list2[-1]
:echo list2[-2]

" slicing
:let list3 = ['a', 'b', 'c', 'd', 'e']
:echo list3[0:2]
:echo list3[2:100000]
:echo list3[-2:-1]

" concatenation

:let list4 = list1 + list2
:echo list4

" list functions

:let mylist = []
:echo "mylist = " mylist

:call add(mylist, 1)
:echo "mylist = " mylist
:call add(mylist, 2)
:echo "mylist = " mylist
:echo "length of mylist = " len(mylist)

:echo get(mylist, 0, "not-found")
:echo get(mylist, 1, "not-found")
:echo get(mylist, 2, "not-found")

:echo index(mylist, 1)
:echo index(mylist, 2)
" -1 indicates 'not found'
:echo index(mylist, 100) 

:echo join(mylist, ":")
:echo join(mylist, ",")
:echo join(mylist, "/")
:echo join(mylist, "")

:call reverse(mylist)
:echo mylist
:call reverse(mylist)
:echo mylist