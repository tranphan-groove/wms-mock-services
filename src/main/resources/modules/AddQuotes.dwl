%dw 2.0
import * from dw::core::Strings

fun getValue(v) = (
    if (["String", "Number"] contains (typeOf(v) as String)) (
        '"' ++ v ++ '"'
    ) else if (["Object", "Array"] contains (typeOf(v) as String)) (
        convert(v)
    ) else v
)

fun convert(value) = (
    if (typeOf(value) as String == "Object") (
        value mapObject ((v, k) -> {
            ('"' ++ k ++ '"'): getValue(v)
        })
    ) else (
        value map ((v) -> getValue(v))
    )
)

fun execute(data) = replaceAll(write(convert(data), "application/json", {"indent":false}), "\\", "")