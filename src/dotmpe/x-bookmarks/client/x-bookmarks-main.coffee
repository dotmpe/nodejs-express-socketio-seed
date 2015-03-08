define ['jquery', "underscore", 'backbone', 'backbone.localstorage'], ($, _, Backbone)->

	console.log 'x-Bookshelf loading'
	#console.log etch.editableInit

	Location = Backbone.Model.extend
		defaults: () ->
			order: Locations.nextOrder()
			private: true
		togglePrivate: () ->
			this.save(private: ! this.get 'private')
	
	LocationList = Backbone.Collection.extend
		url: '/data/locations'
		model: Location
		#localStorage: new Backbone.LocalStorage("todos-backbone"),
		count: ()->
			this.where(done: true)
		nextOrder: ()->
			if !this.length
				return 1
			return this.last().get('order') + 1

	Locations = new LocationList

	LocationView = Backbone.View.extend(
		tagName: 'li'
		template: _.template($('#item-template').html())
		events:
			"dblclick .view"  : "edit"
			"click a.destroy" : "clear"
			"keypress .edit"  : "updateOnEnter"
			"blur .edit"      : "close"
		initialize: ()->
			@listenTo @model, 'change', @render
			@listenTo @model, 'destroy', @destroy
		render: ()->
			@$el.html(@template(@model.toJSON()))
			@edit = @$('.edit')
			@global_id = @$('.edit > .global_id')
			@ref = @$('.edit > .ref')
			@
		edit: ()->
			@$el.addClass 'editing'
			@edit.show()
			@global_id.focus()
		close: ()->
			return
			@model.save global_id: @$global_id.val(), ref: @$ref.val()
			@clear()
		updateOnEnter: (e) ->
			if e.keyCode == 13
				@close()
		clear: () ->
			@model.destroy()
	)

	AppView = Backbone.View.extend(
		el: $('#locations')
		lctrTemplate: _.template($('#lctr-template').html()),
		statsTemplate: _.template($('#stats-template').html()),
		events:
			#"keypress #new-location":  "createOnEnter"
			#"click #clear-completed": "clearCompleted"
			"click #toggle-all": "toggleAllComplete"
		initialize: ()->
			@input = @$("#new-location")
			@listenTo(Locations, 'add', @addOne)
			@listenTo(Locations, 'reset', @addAll)
			@listenTo(Locations, 'all', @render)
			@footer = @$('footer')
			@main = $('#main')
			Locations.fetch()
		render: ()->
			if Locations.length
				this.main.show()
				this.footer.show()
				this.footer.html(this.statsTemplate(
					count: Locations.length
				))
			else
				#this.main.hide()
				this.footer.hide()
		addOne: (location)->
			view = new LocationView(model: location)
			this.$(".location-list").append view.render().el
		addAll: ()->
			Locations.each(this.addOne, this)
		createOnEnter: (e)->
			if e.keyCode != 13
				return
			if !this.input.val()
				return
			Locations.create(title: this.input.val())
			this.input.val('')
		clearCompleted: ()->
			_.invoke(Locations.done(), 'destroy')
			return false
	)
	App = new AppView 


