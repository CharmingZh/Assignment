" functional programming

" immutability

:function s:Sorted(l)
:  let new_list = deepcopy(a:l)
:  call sort(new_list)
:  return new_list
:endfunction

:let list1 = [2, 1, 3, 5, 4]
:let sorted_list = s:Sorted(list1)
:echo "sorted_list = " sorted_list
:echo "list1 = " list1

:function s:Reversed(l)
:  let new_list = deepcopy(a:l)
:  call reverse(new_list)
:  return new_list
:endfunction

:let reversed_list = s:Reversed(list1)
:echo "reversed_list = " reversed_list
:echo "list1 = " list1

:function s:Append(l, val)
:  let new_list = deepcopy(a:l)
:  call add(new_list, a:val)
:  return new_list
:endfunction

:let appended_list = s:Append(list1, 100)
:echo "appended_list = " appended_list
:echo "list1 = " list1

:function s:Assoc(l, idx, val)
:  let new_list = deepcopy(a:l)
:  let new_list[a:idx] = a:val
:  return new_list
:endfunction

:let assoced_list = s:Assoc(list1, 0, 200)
:echo "assoced_list = " assoced_list
:echo "list1 = " list1

:let dict1 = {"name" : "Bob", "age" : 42, "salary" : 1000 }
:echo "assoced_container = " s:Assoc(dict1, "age", 100)
:echo "dict1 = " dict1

:function s:Pop(l, idx)
:  let new_list = deepcopy(a:l)
:  call remove(new_list, a:idx)
:  return new_list
:endfunction

:let popped_list = s:Pop(list1, 1)
:echo "popped_list = " popped_list
:echo "list1 = " list1

:echo "popped_dict = " s:Pop(dict1, "age")
:echo "dict1 = " dict1

" functions as variables

:let MyFunc = function("s:Append")
:echo MyFunc(list1, 999)

:let funcs = [function("s:Append"), function("s:Pop")]
:echo funcs[1](list1, 2)

" higher-order functions

:function s:Mapped(fn, l)
:  let new_list = deepcopy(a:l)
:  call map(new_list, string(a:fn) . '(v:val)')
:  return new_list
:endfunction

:let mylist = [[1, 2], [3, 4]]
:echo s:Mapped(function("s:Reversed"), mylist)

:function s:Filtered(fn, l)
:  let new_list = deepcopy(a:l)
:  call filter(new_list, string(a:fn) . '(v:val)')
:  return new_list
:endfunction

:let another_list = [[1, 2], [], ['foo'], []]
:echo s:Filtered(function('len'), another_list)

:echo "filtered_dict = " s:Filtered(function("len"), dict1)
:echo "dict1 = " dict1

:function s:Removed(fn, l)
:  let new_list = deepcopy(a:l)
:  call filter(new_list, "!" . string(a:fn) . "(v:val)")
:  return new_list
:endfunction

:echo s:Removed(function("len"), another_list)

:echo "removed_dict = " s:Removed(function("len"), dict1)
:echo "dict1 = " dict1
