namespace :products do
  desc 'Create product records'
  task create_records: :environment do
    product_details = [
      {
        name: 'Running Shoes',
        description: 'Lightweight and durable running shoes for all types of runners.',
        price: 2999.99,
        image_filename: 'running_shoes.jpg'
      },
      {
        name: 'Sneakers',
        description: 'Comfortable sneakers with cushioned insoles for everyday wear.',
        price: 3999.99,
        image_filename: 'sneakers.jpg'
      },
      {
        name: 'High Heels',
        description: 'Elegant high heels with a sleek design, perfect for special occasions.',
        price: 5999.99,
        image_filename: 'high_heels.jpg'
      },
      {
        name: 'Basketball Shoes',
        description: 'Performance basketball shoes with responsive cushioning and ankle support.',
        price: 6999.99,
        image_filename: 'basketball_shoes.jpg'
      },
      {
        name: 'Dress Shoes',
        description: 'Classic dress shoes crafted from premium leather, perfect for formal occasions.',
        price: 2999.99,
        image_filename: 'dress_shoes.jpg'
      },
      {
        name: 'Sandals',
        description: 'Versatile sandals for casual wear, featuring adjustable straps and comfortable footbeds.',
        price: 2299.99,
        image_filename: 'sandals.jpg'
      },
      {
        name: 'Work Boots',
        description: 'Durable work boots with steel toe caps and slip-resistant soles for safety on the job.',
        price: 1999.99,
        image_filename: 'work_boots.jpg'
      },
      {
        name: 'Skate Shoes',
        description: 'Skateboarding shoes with reinforced stitching and grippy outsoles for board control.',
        price: 5499.99,
        image_filename: 'skate_shoes.jpg'
      }
    ]

    # Iterate over each product hash and create the product with attached image
    product_details.each do |product_detail|
      product = Product.new(name: product_detail[:name], description: product_detail[:description], price: product_detail[:price])
      image_path = Rails.root.join('app', 'assets', 'images', product_detail[:image_filename])

      # Check if the image file exists before attaching it
      if File.exist?(image_path)
        product.picture.attach(io: File.open(image_path), filename: product_detail[:image_filename])
        product.save!
        puts 'Product record created successfully.'
      else
        puts "Image file '#{product_detail[:image_filename]}' not found at '#{image_path}'. Skipping product creation."
      end
    end
  end
end
