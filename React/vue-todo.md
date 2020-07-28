## Vue


```js
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>

<div id="app">
<ul>
<li v-for="item in items">{{ item }}</li>
</ul>
	
<input type="text" v-model="newItem">
<button v-on:click="addItem">Add #{{items.length + 1}}</button>
</div>


<script>

var app = new Vue({
	el: "#app",
	data: {
		items: ["Item 1", "Item 2", "Code"]
	},
	
	methods: {
		addItem(){
			this.items.push(this.newItem);
		}
	}
});
	
	
// 19:31, 28/07/20
</script>
```
