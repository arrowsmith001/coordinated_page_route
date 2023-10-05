# Coordinated Page Route

A dart package for Flutter that allows co-ordinated page transitions that animate the previous route as well as the incoming route.

https://github.com/arrowsmith001/coordinated_page_route/assets/68137859/3a761ef6-ced1-45a0-a4b1-638975061707

## Features

Allows fully customizable animation of the outgoing route page that is synchronized with the incoming route animation.

This package also includes some examples that will hopefully cover some common use cases:

* [**`SlidingPushRoute`**](https://github.com/arrowsmith001/coordinated_page_route/blob/755b21299df0b162886018a35ad12078ea163678/lib/src/routes/abstract/sliding_push_route.dart): Abstract class representing the case where an incoming route will "push" out the previous route as it slides in. An initial offset must be specified in subclasses which determines the entry page's initial offset from the center. The exit page will animate to the negative of this offset. This effect works particularly well when at least one of dx or dy has a magnitude of 1 to ensure the pages are in constant contact.

  The following implement `SlidingPushRoute` in a particular direction:

    * [**`ForwardPushRoute`**](https://github.com/arrowsmith001/coordinated_page_route/blob/755b21299df0b162886018a35ad12078ea163678/lib/src/routes/sliding_push_routes/forward_push_route.dart)
    * [**`BackwardPushRoute`**](https://github.com/arrowsmith001/coordinated_page_route/blob/755b21299df0b162886018a35ad12078ea163678/lib/src/routes/sliding_push_routes/backward_push_route.dart)
    * [**`UpwardPushRoute`**](https://github.com/arrowsmith001/coordinated_page_route/blob/755b21299df0b162886018a35ad12078ea163678/lib/src/routes/sliding_push_routes/upward_push_route.dart)
    * [**`DownwardPushRoute`**](https://github.com/arrowsmith001/coordinated_page_route/blob/755b21299df0b162886018a35ad12078ea163678/lib/src/routes/sliding_push_routes/downward_push_route.dart)


* 'MultiTransitionCoordinatedRoute': Abstract class that tries to simplify the process of adding numerous transitions (i.e. sliding, fading, zooming...) altogether. Work in progress, subject to change.

    * [**`CoordinatedZoomFadeRoute`**](https://github.com/arrowsmith001/coordinated_page_route/blob/755b21299df0b162886018a35ad12078ea163678/lib/src/routes/coordinated_zoom_fade_route/coordinated_zoom_fade_route.dart): An example of a more visually interesting fully custom transition that is now possible. The outgoing route expands and fades out while the incoming route expands from a small size and fades in. Because this transition is see-through this should be implemented using transparent pages with the Navigator on an opaque background. 


## Getting started

See [example](https://github.com/arrowsmith001/coordinated_page_route/tree/755b21299df0b162886018a35ad12078ea163678/example/lib).


## Usage

You must include a `CoordinatedRouteObserver` in the `NavigatorObserver` list for any Navigator that you wish to take advantage of the coordinated animation.

For a `MaterialApp`, that looks like this:

```
MaterialApp(
      navigatorObservers: 
      [
        CoordinatedRouteObserver() // <--- This must go here!
      ]
    )
```

For a standalone `Navigator`:
```
Navigator(
      observers: 
      [
        CoordinatedRouteObserver() // <--- This must go here!
      ]
    )
```

Then simply push your route like normal:
```

Navigator.of(context).push(ForwardPushRoute((context) => MyPage())),

```

To make your own animated transitions, simply extend the `CoordinatedPageRoute` base class and implement the following:

* **getEntryTransition**: a function that takes a `BuildContext`, `Animation` and child `Widget` and returns the transformed widget. This is simply passed to the `transitionsBuilder` of the `PageRouteBuilder` superclass, which you're probably familiar with.
* **getExitTransition**: similar to the `entryTransitionBuilder`, however, in practice the `BuildContext` will be the `BuildContext` of the `Navigator` and the child `Widget` will be captured from the previous route (or more specifically the widget built by the overlay entry containing the page built using the previous route's builder).

Because both builders have access to the same `animation` passed down from the `PageRouteBuilder` of the incoming route, the animations are synchronized.


## Additional information

https://pub.dev/packages/coordinated_page_route
