@module("../../../../public/images/no-image-cover.png?url") external noImageSrc: 'png = "default"
@set external setSrc: ('event, string) => unit = "src"

@react.component
let make = (
  ~image: string,
  ~defaultImage: option<string>=?,
  ~className: option<string>=?,
  ~alt: option<string>=?,
) => {
  <img
    ?className
    ?alt
    src=image
    onError={event => {
      defaultImage
      ->Belt.Option.getWithDefault(noImageSrc)
      ->(
        src => {
          event->ReactEvent.Media.currentTarget->setSrc(src)
        }
      )
    }}
  />
}
