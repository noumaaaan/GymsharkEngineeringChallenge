# GymsharkEngineeringChallenge

## The Brief
Given an API endpoint which will return JSON, parse this and present a list of products within an application. As part of this list, an image should be shown for each product. Various other attributes such as a title, price and colour will also be available. Selecting a product will show further information about said product

## Implementation 
- Designed entirely in SwiftUI with no external libraries involved
- Conforms to the MVVM design pattern
- Use of DTO's and mapping to domain models
- Components are designed to be reusable where appropriate 
- UI designed as multi-column `LazyVGrid` embedded in `NavigationStack`
- Different Loading states dependant on data returned with placeholder images for errors
- Initial loading of images is downscaled to improve performance
- Pull to refresh added to fetch fresh dataset
- Addition of client side sorting to sort by price (this would come from the BE in real world)  
- Minimal tasteful animations where appropriate 
-  Clean and simple design (subjective)

## Screenshots
<table>
  <tbody>
    <tr>
      <td><img src="https://github.com/user-attachments/assets/857a7afa-8241-4d88-a983-8aeb5049bb76"></td>
      <td><img src="https://github.com/user-attachments/assets/1865a456-88a4-4cc4-8453-18a4f8e04297"></td>
      <td><img src="https://github.com/user-attachments/assets/4597df0e-2e34-48c6-ab02-10fcc21166c8"></td>
    </tr>
  </tbody>
</table>
