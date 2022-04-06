" dictionaries

" for some reason, keys are always coerced to strings in VimScript

:let d1 = {"a" : 1, 100 : 2}
:echo d1
:echo d1["a"]
:echo d1["100"]
:echo d1[100]

:let d2 = {"name" : "Bob", "age": 42, "salary": "Over 9900!", 911: "123-456-789" }
:echo d2
:echo d2.name
:echo d2.age
:echo d2.salary
:echo d2.911

:let d3 = {}
:echo d3
:let d3.a = 100
" this does not work
:let d2["b"] = 200
:let d3.c = 300
:echo d3

" removing entries - remove if you wish to use the removed value else unlet
" (pure side-effect)

:call remove (d3, "a")
:echo d3
:unlet d3.c
:echo d3

" dictionary functions

:let employees = [{"name" : "Bob", "age": 42, "salary" : 100}, {"name": "Steve", "age": 18, "salary": 2000}, {"name": "Anna", "age": 25, "salary": 1000}]
:echo employees

:echo get(employees[0], "name", "not-available")
:echo get(employees[1], "age", "not-available")
:echo get(employees[2], "salary", "not-available")

:echo has_key(employees[0], "age")
:echo has_key(employees[2], "salary")
:echo has_key(employees[1], "favourite food")

:echo items(employees[0])

:for emp in employees
:  echo items(emp)
:endfor

:function! s:Display_employee(emp)
:  echo "Name: " get(a:emp, "name", "not-available")
:  echo "Age: " get(a:emp, "age", "not-available")
:  echo "Salary: " get(a:emp, "salary", "not-available") 
:  echo " "
:endfunction

:for emp in employees
:  call s:Display_employee(emp)
:endfor