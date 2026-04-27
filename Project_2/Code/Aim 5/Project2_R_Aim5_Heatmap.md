### Generate the initial matrix
```r
heatmap_matrix <- all_results %>%
  group_by(Family, Comparison) %>%
  summarise(L2FC = mean(log2FoldChange), .groups = 'drop') %>%
  pivot_wider(names_from = Comparison, values_from = L2FC) %>%
  column_to_rownames("Family") %>%
  as.matrix()

heatmap_matrix[is.na(heatmap_matrix)] <- 0
```

### Define the side-by-side order. This ensures Cort (I) is next to Cort (N), etc.
```r
desired_order <- c(
  "Cort (I)", "Cort (N)", 
  "Mes (I)", "Mes (N)", 
  "Cort + Mes (I)", "Cort + Mes (N)",
  "Triple Therapy (I)", "Triple Therapy (N)",
  "Cort vs Mes (I)", "Cort vs Mes (N)"
)

### Filter for only the columns that actually exist in data and reorder
existing_cols <- intersect(desired_order, colnames(heatmap_matrix))
heatmap_matrix <- heatmap_matrix[, existing_cols]
```

### Plot heatmap
```r
pheatmap(heatmap_matrix, 
         color = colorRampPalette(c("navy", "white", "firebrick3"))(50), 
         main = "Taxonomic Shifts: Treatment Comparison (I vs N)", 
         
         # --- CLUSTERING ---
         cluster_cols = FALSE,  
         cluster_rows = TRUE,   
         
         # --- GRID CONTROL ---
         cellwidth = 30,         
         cellheight = 20,        
         border_color = "white", 
         
         # --- FONT & SPACING ---
         fontsize_col = 12,      
         fontsize_row = 12,   
         angle_col = 45,         
         filename = "Aim5_Final_Heatmap_v2.png"
)
```
