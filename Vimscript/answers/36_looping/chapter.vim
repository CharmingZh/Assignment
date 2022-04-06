" looping

:let c = 0

:for i in [1, 2, 3, 4, 5]
:  let c += i
:endfor

:echo c

:let fruits = ["apples", "bananans", "oranges", "lychee", "pineapples"]
:for fruit in fruits 
:  echo fruit
:endfor

:let d = 1
:let total = 0

:while d <= 5
:  let total += d
:  let d += 1
:endwhile

:echo total