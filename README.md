# Marvel Characters

### Description

This project is based on two screens. The first one will show a list of characters from Marvel provided by Marvel API. This list also has pagination to load more characters while scrolling down. Also has a filter to get a specific character. 
Tapping on one character will show you the second screen that contains more detail about the character.

### Architecture

The project is based on the VIPER architecture pattern. I choose this pattern for scalability. That means that It would be easier and more comfortable to continue with the flow about Characters and even if you want to add another module, like stories or comics. The project is divided by Scenes. Each Scene contains a full view and the full components for a VIPER architecture

The **Router** is the one that initializes and synchronizes all of the VIPER components with each other.
   
The **Presenter** is the component that manages all the traffic between components (View, Router, Interactor) and prepares the view logic

And the **Interactor** prepares the entities from the data that is received from, in this case, the API.
 
 
You can initialize the whole Scene by adding:
```
MyAwesomeRouter.createModule(from: session)
``` 
where `session` is the repository that needs to make API calls. This repository is created in order to avoid the common problems that have the famous Singleton pattern. In this case, I have this repository that each one would manage all the endpoints and parameters needed.

In this repository, you have to include their Router conforming to `MarvelAPIRouter` that contains all the management of the Request and the repository that interacts directly with the API.

If you have any doubs about how to continue this pattern, please contact to @gvizeu
