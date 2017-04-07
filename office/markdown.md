# Usage of Markdown
- ## Title
# level 1
## level 2
### lelel 3
#### levle 4
##### lelel 5

- ## List
### no sequence
 - list 1
    + list 1.1
    + list 1.2
 - list 2
 - list 3

 ### sequence
 1. list 1
    * list 1.1
    * list 1.2
 2. list 2
 3. lit 3

- ## Quote
> We believe that writing is about content, about what you want to say - not about fancy formating.
> 我们坚信写作写的是内容，所思所想， 而不是花样格式。
> -- Ulyssess for Mac

- ## Bold/Italic
**This is Bold**
*This is Italic*

- ## Link and Picture
[Remarkable](http://remarkableapp.github.io/linux.html)
![Remarkable](http://remarkableapp.github.io/images/remarkable.png)

- ## Split line
This is first paragraph.
 ***
This is second paragraph.

- ## Table

| Tables        | Are           | Cool  |
| ------------- | :-----------: | -----:|
| col 3 is      | right-aligned | $1600 |
| col 2 is      | centereed     | $12   |
| zebra stripes | are neat      | $1    |

- ## code

 ```
 void main(int argc, unsigned char* argv[]){
    printf("Hello, markdown!");
    return 0;
 }
 ```
- ## To-do List
 - [x] Issue done
   * [x] task done
 - [] todo

- ## Flowchart

 ```
 graph TD
    A[Christmas] --> B(Go shoppng)
    B --> C{Let me think}
    C --> |1| D[Laptop]
    C --> |2| E[iPhone]
    C --> |3| F[Car]
 ```

- ## Gantt
 ``` 
 gantt
 dateFormat YYYY-MM-DD
 title 产品计划表
 section 初期阶段 
 明确需求: 2017-03-21, 5d
 
 section 中期阶段
 研发设计: 2017-03-26, 5d
 代码开发: 2017-03-31, 3d
 
 section 后期阶段
 研发自测: 2017-04-03, 2d
 测试测试: 2017-04-04, 3d
 
 ```
- ## Math 
 $y = x^2$
 ***
 $(x + y)^2 = x^2 + 2xy + y^2$
 ***
 $\oint_C x^3\,dx + 4y^2\,dy$
 ***
 $2 = (\frac{(3 - x)\times 2}{3-x})$
 ***
 $\sum_{m=1}^\infty\sum_{n=1}^\infty\frac{m^2\,n}{3^m(m\,3^n + n\,3^m)}$
 ***
 $\phi_n(\kappa) = \frac{1}{4\pi^2\kappa^2}\int_0^\infty\frac{\sin(\kappa\,R)}{\kappa\,R}\frac{\partial}{\partial R}[R^2\frac{\partial D_n(R)}{\partial R}]\,dR$
 ***
