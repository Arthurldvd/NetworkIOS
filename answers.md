
## LazyVgrid
C'est utile pour afficher une grille qui est grande scrollable avec des lignes, une lazyGrid va servir à afficher les images que lorsqu'elles seront chargées.

-   Flexible : La largeur de la colonne s'adapte à l'écran.
-  Fixed : La largeur de la colonne est fixe.
-  Adaptative : Il faut définir une largeur minimale pour que les colonnes s'adaptent.


On utilise flexible pour avoir une interface qui s'adapte à tout type d'écran.

Les images prennent toute la largeur de l'écran car on a qu'une seul colonne et qu'on utilise un .fill . 


## Grid 

1.  **`.resizable()`:** Cela sert à ce que l'image puisse être redimensionner et s'adapter.
2. **`scaledToFill()`:** cela sert à modifier l'échelle de l'image pour remplir entièrement la place qu'elle occupe en gardant son ratio hauteur/largeur
3. **`.frame(width: geo.size.width, height: geo.size.height)`** Définit la largeur et la hauteur de notre image 
4. **`.clipped()`** : Coupe l'image pour qu'elle s'affiche correctement et ne dépasse pas de l'espace prévu.

On récupère dynamiquement en appelant l'API.

 ## Appel Réseau
**Async/Await** : On utilise généralement await async lord d'appel réseaux

**Combine** : cela permet de faire plusieurs tâches en même temps et gérer les données.

**CompletionHandler / GCD** : Il se sert du dispatcher pour prendre une décision sur la temporalité des opérations qu'il effectue.
 
